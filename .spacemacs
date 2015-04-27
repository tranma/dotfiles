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
   perspectives
   auto-completion
   auctex
   themes-megapack
   haskell
   (git :variables
     git-magit-status-fullscreen t
     git-enable-github-support t
     git-gutter-use-fringe t)
   (haskell :variables
     haskell-enable-shm-support)
))

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
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)

  (windmove-default-keybindings)
  (setq-default truncate-lines t)
  (setq projectile-enable-caching t)
  (global-git-gutter-mode t)
  (tooltip-mode 1)

  (custom-set-variables
   '(global-hl-line-mode t)
   '(haskell-interactive-popup-errors nil)
   '(haskell-stylish-on-save nil)
   '(haskell-tags-on-save t)
   '(company-ghc-show-info t)
   '(tooltip-use-echo-area nil)
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

  (global-set-key (kbd "C-c C-o") 'haskell-compile)
)
