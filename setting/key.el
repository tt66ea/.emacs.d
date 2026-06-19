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
;; corfu 自动补全，无需额外绑定 (默认 M-TAB = completion-at-point)
(global-set-key (kbd "M-x") 'execute-extended-command)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;; == Search enhancements (Emacs 30) ==
(setq grep-use-headings t)              ; grep 结果按文件分组显示
(setq imenu-flatten t)                   ; imenu 扁平化
(global-set-key (kbd "C-x p r") 'rgrep) ; 项目内递归 grep
;; C-x p g = project-find-regexp (project.el 默认)

(provide 'key)
;;; key.el ends here
