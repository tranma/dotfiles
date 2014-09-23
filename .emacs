;;--------------------------------------------------------------------
;; environment
;;--------------------------------------------------------------------
(add-to-list 'load-path "/Users/tranma/.emacs.d/packages/flycheck-20140328.743")
(add-to-list 'load-path "/Users/tranma/.emacs.d/packages/flycheck-haskell-20140407.135")

(setenv "PATH" (concat (getenv "PATH") ":/Users/tranma/ghc/7.8.2/bin"))
(setq exec-path (append exec-path '("/Users/tranma/ghc/7.8.2/bin")))
(setenv "PATH" (concat (getenv "PATH") ":/Users/tranma/.cabal/bin"))
(setq exec-path (append exec-path '("/Users/tranma/.cabal/bin")))

;;--------------------------------------------------------------------
;; auto install packages
;; doesn't work
;;--------------------------------------------------------------------

; list the repositories containing them
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(require 'package)

; activate all the packages (in particular autoloads)
(package-initialize)

;;--------------------------------------------------------------------
;; editor
;;--------------------------------------------------------------------

; appearance
(load-theme 'jujube t)
(scroll-bar-mode -1)
; doesn't work in aquamacs??
(global-hl-line-mode 1)
;(highlight-current-minor-mode)
;(set-face-background 'highlight-current-line-face "grey25")

(add-hook 'before-save-hook 'delete-trailing-whitespace)

; vim
(evil-mode 1)
(setq evil-want-fine-undo t)

; tabs
(setq tab-stop-list (number-sequence 4 200 4))

; disable scrollbars and file tabs
;(tabbar-mode 0)
(scroll-bar-mode 0)

; 80 col
;(require 'fill-column-indicator)
;(turn-on-fci-mode)
;(setq fci-rule-column 80)
;(setq fci-rule-width 1)
;(setq fci-rule-color "dim grey")
;(add-hook 'c-mode-hook 'fci-mode)
;(add-hook 'LaTeX-mode-hook 'fci-mode)

;;--------------------------------------------------------------------
;; flycheck & autocomp
;;--------------------------------------------------------------------
(require 'flycheck)
;(require 'flycheck-haskell)
;(add-to-list 'evil-emacs-state-modes 'flycheck-error-list)
;(add-to-list 'evil-emacs-state-modes 'flycheck-error-list-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

(global-auto-complete-mode 1)

;;--------------------------------------------------------------------
;; haskell
;;--------------------------------------------------------------------
(require 'haskell-mode)

(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-process-type (quote cabal-repl)))
(add-to-list 'evil-emacs-state-modes 'haskell-interactive-mode)
(add-to-list 'evil-emacs-state-modes 'haskell-presentation-mode)

(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
(define-key haskell-mode-map (kbd "C-c h") 'haskell-hoogle)
(setq haskell-hoogle-command "hoogle")

(add-hook 'haskell-mode-hook #'flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)

;; hack for TH
(flycheck-define-checker haskell-ghc-hack
  "A Haskell syntax and type checker using ghc.

See URL `http://www.haskell.org/ghc/'."
  :command ("ghc" "-Wall"
            ;; Include the parent directory of the current module tree, to
            ;; properly resolve local imports
            (eval (concat
                   "-i"
                   (flycheck-module-root-directory
                    (flycheck-find-in-buffer flycheck-haskell-module-re))))
            (option-flag "-no-user-package-db"
                         flycheck-ghc-no-user-package-database)
            (option-list "-package-db" flycheck-ghc-package-databases)
            (option-list "-i" flycheck-ghc-search-path s-prepend)
            source)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ":"
            (or " " "\n    ") "Warning:" (optional "\n")
            (one-or-more " ")
            (message (one-or-more not-newline)
                     (zero-or-more "\n"
                                   (one-or-more " ")
                                   (one-or-more not-newline)))
            line-end)
   (error line-start (file-name) ":" line ":" column ":"
          (or (message (one-or-more not-newline))
              (and "\n" (one-or-more " ")
                   (message (one-or-more not-newline)
                            (zero-or-more "\n"
                                          (one-or-more " ")
                                          (one-or-more not-newline)))))
          line-end))
  :modes haskell-mode
  :next-checkers ((warnings-only . haskell-hlint)))

;;--------------------------------------------------------------------
;; helm
;;--------------------------------------------------------------------
(global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)
(put 'set-goal-column 'disabled nil)

(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))

;;--------------------------------------------------------------------
;; org
;;--------------------------------------------------------------------
(require 'org)
(require 'org-bullets)

;; Standard key bindings
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-log-done t)

;;--------------------------------------------------------------------
;; auctex
;;--------------------------------------------------------------------

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

;; Use Skim as viewer, enable source <-> PDF sync
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background
(setq TeX-view-program-selection '((output-dvi "open")
				  (output-pdf-skim-running "Skim")
				  (output-pdf "open")
				  (output-html "open")))
(setq TeX-view-program-list
     '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))

(server-start); start emacs in server mode so that skim can talk to it

;;--------------------------------------------------------------------
;; custom functionalities
;;--------------------------------------------------------------------
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

;;--------------------------------------------------------------------
;; agda
;;--------------------------------------------------------------------
(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

;;--------------------------------------------------------------------
;; web
;;--------------------------------------------------------------------
(require 'emmet-mode)

;;--------------------------------------------------------------------
;; terminal
;;--------------------------------------------------------------------
(require 'multi-term)
(setq multi-term-program "/bin/zsh")

;;--------------------------------------------------------------------
;; from customizations.el
;;--------------------------------------------------------------------
(set-face-attribute 'default nil
                    :family "PragmataPro" :height 120 :weight 'normal)

(provide '.emacs)
;;; .emacs ends here
