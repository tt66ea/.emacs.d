;;; package --- tt66ea
;;; Commentary:
;;; Code:

(defun kill-all-buffer ()
  "Kill all buffer."
  (interactive)
  (dolist (buffer (buffer-list)) (kill-buffer buffer)))

(defun kill-other-buffer ()
  "Close all of other buffer."
  (interactive)
  (dolist (buffer (delq (current-buffer) (buffer-list))) (kill-buffer buffer)))

(defun my/switch-im (lang)
  "切换输入法.  LANG = en时为英文."
  (start-process "fcitx5-remote" nil "fcitx5-remote" (if (string= lang "en")"-c" "-o"))
  )

(defun my/switch-im-org (lang)
  "切换输入法，仅在org-mode下生效.  LANG = en时为英文."
  (when (derived-mode-p 'org-mode)
    (start-process "fcitx5-remote" nil "fcitx5-remote" (if (string= lang "en")"-c" "-o")))
  )

(use-package evil
  :ensure t
  :init (evil-mode 1)
  :config
  (setq evil-leader/in-all-states 1)
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "f" 'find-file)
  (evil-leader/set-key "b" 'switch-to-buffer)
  (evil-leader/set-key "k" 'kill-buffer)
  (evil-leader/set-key "q" 'kill-all-buffer)
  ;; (add-hook 'evil-normal-state-entry-hook (lambda () (my/switch-im "en")))
  ;; (add-hook 'evil-motion-state-entry-hook (lambda () (my/switch-im "en")))
  ;; (add-hook 'evil-visual-state-entry-hook (lambda () (my/switch-im "en")))
  ;; (add-hook 'evil-operator-state-entry-hook (lambda () (my/switch-im "en")))
  ;; (add-hook 'evil-emacs-state-entry-hook (lambda () (my/switch-im-org "zh")))
  ;; (add-hook 'evil-insert-state-entry-hook (lambda () (my/switch-im-org "zh")))
)
;; fcitx.vim like配置
(use-package fcitx
  :init
  (setq fcitx-use-dbus nil)
  (setq fcitx-remote-command "fcitx5-remote"))
  (fcitx-default-setup)
(provide 'evil)
;;; evil.el ends here
