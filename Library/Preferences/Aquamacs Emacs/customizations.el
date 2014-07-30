(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 305 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(custom-safe-themes
   (quote
    ("579e9950513524d8739e08eae289419cfcb64ed9b7cc910dd2e66151c77975c4" default)))
 '(default-frame-alist
    (quote
     ((cursor-type . box)
      (internal-border-width . 0)
      (vertical-scroll-bars)
      (modeline . t)
      (fringe)
      (mouse-color . "#839496")
      (cursor-color . "#839496")
      (background-mode . dark)
      (tool-bar-lines . 1)
      (menu-bar-lines . 1)
      (right-fringe . 17)
      (left-fringe . 7)
      (background-color . "#151515")
      (foreground-color . "#e8e8d3")
      (font . "-*-PragmataPro-normal-normal-normal-*-11-*-*-*-m-0-iso10646-1")
      (fontsize . 0)
      (font-backend mac-ct ns))))
 '(deft-directory "/Users/tranma/Dropbox/org")
 '(deft-extension "org")
 '(deft-text-mode (quote org-mode))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-show-sources-in-directories-buffer (quote always))
 '(ecb-source-file-regexps
   (quote
    ((".*"
      ("\\(^\\(\\.\\|#\\)\\|\\(~$\\|\\.\\(elc\\|obj\\|o\\|class\\|lib\\|dll\\|a\\|so\\|cache\\)$\\)\\)\\|\\(^Icon\\)")
      ("^\\.\\(emacs\\|gnus\\)$")))))
 '(ecb-source-path (quote (("/" "/"))))
 '(flycheck-display-errors-delay 2048)
 '(haskell-font-lock-symbols nil)
 '(haskell-hoogle-command "hoogle-me")
 '(haskell-mode-hook
   (quote
    (turn-on-haskell-indentation turn-on-haskell-simple-indent flycheck-mode)))
 '(haskell-process-log t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-process-use-presentation-mode t)
 '(initial-frame-alist
   (quote
    ((vertical-scroll-bars)
     (modeline . t)
     (fringe)
     (mouse-color . "#839496")
     (cursor-color . "#839496")
     (tool-bar-lines . 1)
     (menu-bar-lines . 1)
     (right-fringe . 15)
     (left-fringe . 6)
     (font . "-*-PragmataPro-normal-normal-normal-*-11-*-*-*-m-0-iso10646-1")
     (fontsize . 0)
     (font-backend mac-ct ns))))
 '(ns-tool-bar-display-mode (quote labels) t)
 '(ns-tool-bar-size-mode (quote regular) t)
 '(one-buffer-one-frame-mode t nil (aquamacs-frame-setup))
 '(org-agenda-file-regexp "\\`[^.].*_agenda\\.org\\'")
 '(org-agenda-files (quote ("~/Dropbox/org/")))
 '(org-hide-leading-stars t)
 '(org-startup-indented t)
 '(speedbar-after-create-hook nil)
 '(speedbar-default-position (quote left))
 '(tabbar-mode nil nil (tabbar))
 '(visual-line-mode nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-buffer-directory ((t (:background "#333333" :foreground "DarkRed"))))
 '(helm-ff-directory ((t (:background "#333333" :foreground "DarkRed"))))
 '(helm-selection ((t (:background "knobColor" :underline t))))
 '(vertical-border ((t (:foreground "#282a2e"))))
 '(mode-line ((t (:inherit aquamacs-variable-width :box nil :height 85))))
 '(mode-line-inactive ((t (:inherit aquamacs-variable-width :background "#2F2F2F" :box nil :height 85))))

 '(c-mode-default ((t (:inherit prog-mode-default :height 130 :family "PragmataPro"))) t)
 '(ecb-default-highlight-face ((t (:background "#6c6c9c"))))
 '(haskell-mode-default ((t (:inherit haskell-parent-mode-default :height 110 :family "PragmataPro"))) t)
 '(latex-mode-default ((t (:inherit text-mode-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "PragmataPro"))))
 '(markdown-mode-default ((t (:inherit text-mode-default :height 120 :family "PragmataPro"))) t)
 '(org-mode-default ((t (:inherit outline-mode-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "PragmataPro")))))
