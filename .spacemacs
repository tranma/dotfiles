;; Spacemacs settings
(setq-default dotspacemacs-default-font '("PragmataPro"
                                          :size 13
                                          :weight normal
                                          :width normal
                                          :powerline-scale 1.5))

;;; Layers
(setq-default dotspacemacs-configuration-layers '(
   ;; private packages 
   ;; other packages
   osx
   haskell
   perspectives
   company-mode
   auctex
   themes-megapack
   (git :variables
     git-magit-status-fullscreen t
     git-enable-github-support t
     git-gutter-use-fringe t)))

(setq-default
   dotspacemacs-themes '(hc-zenburn)
   dotspacemacs-smooth-scrolling t
)

;; Before loading packages
(defun dotspacemacs/init ()
  (add-to-list 'exec-path "~/ghc/bin/")
  (add-to-list 'exec-path "~/.cabal/bin/")
  (add-to-list 'exec-path "~/bin/")
  (fringe-mode '(nil . 0))
)

;; After loading packages
(defun dotspacemacs/config ()
  (load-file "~/.emacs.d/private/haskell-flycheck.el")
  (windmove-default-keybindings)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)

  (custom-set-variables
   '(ahs-case-fold-search nil)
   '(ahs-default-range (quote ahs-range-whole-buffer))
   '(ahs-idle-interval 0.25)
   '(ahs-idle-timer 0 t)
   '(ahs-inhibit-face-list nil)
   '(flycheck-haskell-ghc-executable "/Users/tranma/ghc/bin")
   '(global-hl-line-mode t)
   '(haskell-interactive-popup-error nil)
   '(haskell-notify-p t)
   '(haskell-process-auto-import-loaded-modules t)
   '(haskell-process-log t)
   '(haskell-process-suggest-remove-import-lines t)
   '(haskell-process-type (quote auto))
   '(haskell-process-use-presentation-mode t)
   '(haskell-process-suggest-remove-import-lines t)
   '(haskell-process-auto-import-loaded-modules t)
   '(haskell-process-log t)
   '(haskell-process-use-presentation-mode t)
   '(haskell-process-type 'cabal-repl)
   '(haskell-stylish-on-save nil)
   '(haskell-tags-on-save t)
   '(ring-bell-function (quote ignore) t))
  
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:foreground "#DCDCCC" :background "#313131"))))
   '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
   '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
   '(hl-line ((t (:background "#3d3d3d")))))

  (setq-default truncate-lines t)
  (global-hl-line-mode -1)
  (global-vi-tilde-fringe-mode -1)
  (setq projectile-enable-caching t)
  (global-git-gutter-mode t)
)
