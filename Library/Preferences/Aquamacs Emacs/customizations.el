(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 305 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(default-frame-alist
    (quote
     ((cursor-type . box)
      (internal-border-width . 0)
      (modeline . t)
      (fringe)
      (mouse-color . "#839496")
      (cursor-color . "#839496")
      (tool-bar-lines . 1)
      (menu-bar-lines . 1)
      (right-fringe . 15)
      (left-fringe . 6)
      (font . "-*-Source Code Pro-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
      (fontsize . 0)
      (font-backend mac-ct ns)
      (vertical-scroll-bars))))
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
 '(haskell-mode-hook
   (quote
    (turn-on-haskell-indentation turn-on-haskell-simple-indent flycheck-mode)))
 '(haskell-program-name "cabal repl")
 '(haskell-tags-on-save t)
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
     (font . "-*-Source Code Pro-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
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
 '(c-mode-default ((t (:inherit prog-mode-default :height 130 :family "Source Code Pro"))) t)
 '(ecb-default-highlight-face ((t (:background "#6c6c9c"))))
 '(latex-mode-default ((t (:inherit text-mode-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "Source Code Pro"))))
 '(markdown-mode-default ((t (:inherit text-mode-default :height 120 :family "Source Code Pro"))) t)
 '(org-mode-default ((t (:inherit outline-mode-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "Source Code Pro")))))
