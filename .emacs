;;--------------------------------------------------------------------
;; environment
;;--------------------------------------------------------------------

; Paths to locally installed ghc and cabal
(setenv "PATH" (concat (getenv "PATH") ":~/ghc/bin"))
(setq exec-path (append exec-path '("~/ghc/bin")))
(setenv "PATH" (concat (getenv "PATH") ":~/.cabal/bin"))
(setq exec-path (append exec-path '("~/.cabal/bin")))

; Start emacs here
(setq inhibit-startup-message t)
(setq default-directory "~/dev")

; Package repos
(require 'package)
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

; Activate all the packages (in particular autoloads)
(package-initialize)

(desktop-save-mode 1)

;;--------------------------------------------------------------------
;; macros
;;--------------------------------------------------------------------

; From https://github.com/juanjux/emacs-dotfiles
(if (fboundp 'with-eval-after-load)
    (defmacro after (feature &rest body)
      "After FEATURE is loaded, evaluate BODY."
      (declare (indent defun))
      `(with-eval-after-load ,feature ,@body))
  (defmacro after (feature &rest body)
    "After FEATURE is loaded, evaluate BODY."
    (declare (indent defun))
    `(eval-after-load ,feature
       '(progn ,@body))))

;;--------------------------------------------------------------------
;; projectile & project-explorer
;;--------------------------------------------------------------------
(require 'projectile)

; PE is useful as projectile only index files when you first open them

;(require 'project-explorer)
;(after 'project-explorer
;  (setq pe/cache-directory "~/.emacs.d/cache/project_explorer")
;  (setq pe/omit-regex (concat pe/omit-regex "\\|dist\\|.*\.hi"))
;  (setq pe/cache-enabled t)
;  (setq pe/width 30)
;  (setq pe/side 'right))
;(global-set-key (kbd "C-x C-f") 'project-explorer-helm)

;;--------------------------------------------------------------------
;; helm
;;--------------------------------------------------------------------

;(require 'helm)
(helm-mode 1)
;; helm settings (TAB in helm window for actions over selected items,
;; C-SPC to select items)
(require 'helm-config)
(require 'helm-misc)
(require 'helm-projectile)
(require 'helm-locate)
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)
(put 'set-goal-column 'disabled nil)
(global-set-key (kbd "C-c h") 'helm-mini)

; helm-projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)

; flycheck
(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))


;;--------------------------------------------------------------------
;; editor
;;--------------------------------------------------------------------

(windmove-default-keybindings)

; appearance
(load-theme 'jujube t)
(scroll-bar-mode -1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; vim
(evil-mode 1)
(setq evil-want-fine-undo t)

; tabs
(setq tab-stop-list (number-sequence 4 200 4))

; disable scrollbars and file tabs
(scroll-bar-mode 0)

;;--------------------------------------------------------------------
;; flycheck & autocomp
;;--------------------------------------------------------------------
(require 'flycheck)
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
 '(flycheck-haskell-ghc-executable "/Users/tranma/ghc/bin/ghc")
 '(flycheck-haskell-runhaskell "/Users/tranma/.cabal/bin/cabal-repl")
 '(haskell-process-type (quote cabal-repl)))
(add-to-list 'evil-emacs-state-modes 'haskell-interactive-mode)
(add-to-list 'evil-emacs-state-modes 'haskell-presentation-mode)

(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
(define-key haskell-mode-map (kbd "C-c h") 'haskell-hoogle)
(setq haskell-hoogle-command "hoogle")

(add-hook 'haskell-mode-hook #'turn-on-haskell-simple-indent)
(add-hook 'haskell-mode-hook #'flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)

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
;(load-file (let ((coding-system-for-read 'utf-8))
;                (shell-command-to-string "agda-mode locate")))

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
                    :family "PragmataPro" :height 130 :weight 'normal)

(provide '.emacs)
;;; .emacs ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
