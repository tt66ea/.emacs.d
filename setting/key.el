;;; package --- tt66ea-keyboard
;;; Commentary:
;;; Code:
(global-set-key [f2] 'open-init-file)
(global-set-key [f6] 'gdb-many-windows) ;;摁F6进入gdb调试
(global-set-key [f7] 'mycompile) ;;摁F7编译
(global-set-key [f8] 'shell) ;;摁F8进入shell
(global-set-key [f9] 'mycompile-gdb)
(define-key key-translation-map (kbd "C-;") (kbd "C-x C-s"))
(global-set-key [C-tab] 'next-buffer)
(global-set-key (kbd "C-<iso-lefttab>") 'previous-buffer)
(with-eval-after-load 'cc-mode
  (define-key c-mode-map [tab] #'company-complete)
  (define-key c++-mode-map [tab] #'company-complete)
  (define-key c++-mode-map [backtab] #'indent-for-tab-command)
)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [backtab] 'indent-for-tab-command)
(global-set-key (kbd "C-.") 'company-complete-common)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(provide 'key)
;;; key.el ends here
