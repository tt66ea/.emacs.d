;;(package-vc-install '(org-mode :url "https://code.tecosaur.net/tec/org-mode" :branch "dev"))
;;(use-package org :load-path "~/.emacs.d/elpa/org-mode/lisp/")
(add-to-list 'load-path "~/.emacs.d/setting")
(load "base.el")
(load "code.el")
(load "file.el")
(load "key.el")
(load "my-evil.el")
(load "typst.el")
(load "modeline.el")
;;(load "org-mode-setting")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function 'browse-url-default-windows-browser)
 '(custom-enabled-themes '(spacemacs-dark))
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476"
     "669e02142a56f63861288cc585bee81643ded48a19e36bfdf02b66d745bcc626"
     "30289fa8d502f71a392f40a0941a83842152a68c54ad69e0638ef52f04777a4c"
     "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26"
     "274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e"
     default))
 '(fci-rule-color "#f8fce8")
 '(hl-paren-background-colors '("#e8fce8" "#c1e7f8" "#f8e8e8"))
 '(hl-paren-colors '("#40883f" "#0287c8" "#b85c57"))
 '(org-agenda-files '("C:/Users/tt66ea/Desktop/"))
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io\\(?:/\\|\\'\\)"
     "\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-bigblow\\.setup\\'"))
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((org-mode :url "https://code.tecosaur.net/tec/org-mode" :branch
               "dev")))
 '(safe-local-variable-values '((company-clang-arguments)))
 '(sml/active-background-color "#98ece8")
 '(sml/active-foreground-color "#424242")
 '(sml/inactive-background-color "#4fa8a8")
 '(sml/inactive-foreground-color "#424242"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


