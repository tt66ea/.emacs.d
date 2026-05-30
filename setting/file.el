;;; package --- tt66ea
;;; Commentary:
;;; Code:
(defun open-init-file()
  "Set defult dir."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(use-package icomplete
  :init (fido-vertical-mode 1))

(provide 'file)
;;; file.el ends here
