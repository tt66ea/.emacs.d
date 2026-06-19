;;; package --- tt66ea
;;; Commentary:
;;; Code:
(defun open-init-file()
  "Set defult dir."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(use-package icomplete
  :init (fido-vertical-mode 1))

;; == Emacs 30 completion UI ==
(setq minibuffer-visible-completions t)   ; 方向键直接在 minibuffer 选补全
(setq completions-sort 'historical)       ; M-x 按使用历史排序

(provide 'file)
;;; file.el ends here
