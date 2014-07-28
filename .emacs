;;--------------------------------------------------------------------
;; environment
;;--------------------------------------------------------------------
(add-to-list 'load-path "/Users/tranma/.emacsload")
(add-to-list 'load-path "/Users/tranma/.emacs.d/packages")

(setenv "PATH" (concat (getenv "PATH") ":/Users/tranma/bin"))
(setq exec-path (append exec-path '("/Users/tranma/bin")))
(setenv "PATH" (concat (getenv "PATH") ":/Users/tranma/.cabal/bin"))
(setq exec-path (append exec-path '("/Users/tranma/.cabal/bin")))
(setenv "PATH" (concat (getenv "PATH") ":/Users/tranma/ghc/bin"))
(setq exec-path (append exec-path '("/Users/tranma/ghc/bin")))

;;--------------------------------------------------------------------
;; auto install packages
;; doesn't work
;;--------------------------------------------------------------------

; list the packages you want
; (setq package-list
; '(auto-complete popup deft ecb emmet-mode evil-matchit evil-visualstar evil goto-chg undo-tree fill-column-indicator flycheck-haskell f dash s dash haskell-mode flycheck pkg-info epl dash f dash s dash s goto-chg haskell-mode helm inkpot-theme jujube-theme magit git-rebase-mode git-commit-mode multi-term org-bullets pkg-info epl dash popup powerline s smotitah solarized-theme sr-speedbar tree-mode undo-tree windata zenburn-theme))

; list the repositories containing them
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(require 'package)

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
; (unless package-archive-contents
;   (package-refresh-contents))

; install the missing packages
; (dolist (package package-list)
;   (unless (package-installed-p package)
;     (package-install package)))

;;--------------------------------------------------------------------
;; flycheck & autocomp
;;--------------------------------------------------------------------
(add-hook 'after-init-hook #'global-flycheck-mode)
(global-auto-complete-mode 1)

;;--------------------------------------------------------------------
;; haskell
;;--------------------------------------------------------------------
(eval-after-load "haskell-mode"
    '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))

(eval-after-load "haskell-cabal"
    '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))

(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)
(add-hook 'haskell-mode-hook #'flycheck-mode)

;; hack for TH
(require 'flycheck)
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
;; sr-speedbar
;;--------------------------------------------------------------------
(require 'sr-speedbar)

(setq speedbar-frame-parameters
      '((minibuffer)
	(width . 40)
	(border-width . 0)
	(menu-bar-lines . 0)
	(tool-bar-lines . 0)
	(unsplittable . t)
	(left-fringe . 0)))
(setq speedbar-hide-button-brackets-flag t)
(setq speedbar-show-unknown-files t)
(setq speedbar-smart-directory-expand-flag t)
(setq speedbar-use-images nil)
(setq sr-speedbar-auto-refresh nil)
(setq sr-speedbar-max-width 70)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width-console 40)

(when window-system
  (defadvice sr-speedbar-open (after sr-speedbar-open-resize-frame activate)
    (set-frame-width (selected-frame)
                     (+ (frame-width) sr-speedbar-width)))
  (ad-enable-advice 'sr-speedbar-open 'after 'sr-speedbar-open-resize-frame)

  (defadvice sr-speedbar-close (after sr-speedbar-close-resize-frame activate)
    (sr-speedbar-recalculate-width)
    (set-frame-width (selected-frame)
                     (- (frame-width) sr-speedbar-width)))
  (ad-enable-advice 'sr-speedbar-close 'after 'sr-speedbar-close-resize-frame))

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
;; web
;;--------------------------------------------------------------------
(require 'emmet-mode)

;;--------------------------------------------------------------------
;; terminal
;;--------------------------------------------------------------------
(require 'multi-term)
(setq multi-term-program "/bin/zsh")

;;--------------------------------------------------------------------
;; editor
;;--------------------------------------------------------------------

;(global-hl-line-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; enable line numbers in the following major modes
(defun linum-hook ()
	(line-number-mode 1))
(add-hook 'haskell-mode-hook 'linum-hook)
(add-hook 'LaTeX-mode-hook 'linum-hook)

; vim
(evil-mode 1)
(setq evil-want-fine-undo t)
;(require 'evil-matchit)
;(global-evil-matchit-mode 1)
;(require 'evil-mode-line)
;(require 'evil-visualstar)

; tabs
(setq tab-stop-list (number-sequence 4 200 4))

; disable scrollbars and file tabs
(tabbar-mode 0)
(scroll-bar-mode 0)

; appearance
(load-theme 'zenburn t)
(scroll-bar-mode -1)

; 80 col
(require 'fill-column-indicator)
(setq fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "gray")
(add-hook 'c-mode-hook 'fci-mode)
(add-hook 'haskell-mode-hook 'fci-mode)
(add-hook 'LaTeX-mode-hook 'fci-mode)

(provide '.emacs)
;;; .emacs ends here
