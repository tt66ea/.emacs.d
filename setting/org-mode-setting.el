;; -*- lexical-binding: t; -*-
;;; package --- tt66ea-keyboard
;;; Commentary:
;;; Code:
(add-hook 'org-mode-hook (lambda () (setq truncate-lines 'nil)))
;; (use-package org-latex-impatient
;;   :defer t
;;   :hook (org-mode . org-latex-impatient-mode)
;;   :init
;;   (setq org-latex-impatient-tex2svg-bin
;;         ;; location of tex2svg executable
;;         "~/node_modules/mathjax-node-cli/bin/tex2svg"))
;;(use-package org :load-path "~/.emacs.d/elpa/org-mode/lisp/")
(use-package anki-editor
  :vc (:url "https://github.com/anki-editor/anki-editor" :rev :newest)
  :config (setq anki-editor-default-note-type "问答题")
  (evil-leader/set-key "a" 'anki-editor-ui)
  (setq anki-editor-latex-style 'mathjax)
  (define-key org-mode-map (kbd "M-c") 'anki-editor-cloze-dwim))


(use-package cdlatex
  ;;:after tex
  :init
  (defun my/set-cdlatex-math-modify-alist ()
    (setq cdlatex-math-modify-alist
          '((107 "\\mathfrak" nil t nil nil)
            (66 "\\mathbb" nil t nil nil))))
  (add-hook 'org-mode-hook #'turn-on-org-cdlatex)
  (add-hook 'org-mode-hook #'my/set-cdlatex-math-modify-alist)
  :config
  (my/set-cdlatex-math-modify-alist)
  )
;;(setq org-preview-latex-default-process 'dvisvgm)
;;(setq org-latex-compiler "xelatex")
(setq org-highlight-latex-and-related '(native latex entities))
(setq org-pretty-entities t)
(setq org-pretty-entities-include-sub-superscripts nil)
(set-face-attribute 'default nil :height 160)
(setq my/latex-preview-scale 1.6)
(setq org-format-latex-options '(:foreground default :background default :scale 1.6 :html-foreground "Black" :html-background "Transparent" :html-scale 1.6 :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
;;(pdf-tools-install)
(use-package org-latex-preview
  :init
  (defvar my/org-tex-tmp-dir (file-name-as-directory (expand-file-name "~/tex_tmp/")))
  (unless (file-directory-p my/org-tex-tmp-dir)
  (make-directory my/org-tex-tmp-dir t))
  (defun my/org-latex-preview-tmp-setup ()
    (setq-local temporary-file-directory my/org-tex-tmp-dir)
    (setq-local org-latex-preview-cache my/org-tex-tmp-dir))
  (add-hook 'org-mode-hook #'my/org-latex-preview-tmp-setup)
  :config
  (defun my/org-latex-preview-create-tex-in-tmp (orig processing-info fragments appearance-options)
    (if (file-remote-p default-directory)
    (funcall orig processing-info fragments appearance-options)
    (let ((default-directory my/org-tex-tmp-dir))
         (funcall orig processing-info fragments appearance-options))))
  (advice-add 'org-latex-preview--create-tex-file :around #'my/org-latex-preview-create-tex-in-tmp)
  ;; Increase preview width
  (plist-put org-latex-preview-appearance-options
             :page-width 0.8)

  ;; ;; Use dvisvgm to generate previews
  ;; ;; You don't need this, it's the default:
  ;; (setq org-latex-preview-process-default 'dvisvgm)
  
  ;; Turn on auto-mode, it's built into Org and much faster/more featured than
  ;; org-fragtog. (Remember to turn off/uninstall org-fragtog.)
  (add-hook 'org-mode-hook 'org-latex-preview-mode)

  ;; ;; Block C-n, C-p etc from opening up previews when using auto-mode
  ;; (setq org-latex-preview-auto-ignored-commands
  ;;       '(next-line previous-line mwheel-scroll
  ;;         scroll-up-command scroll-down-command))

  ;; ;; Enable consistent equation numbering
  ;; (setq org-latex-preview-numbered t)

  ;; Bonus: Turn on live previews.  This shows you a live preview of a LaTeX
  ;; fragment and updates the preview in real-time as you edit it.
  ;; To preview only environments, set it to '(block edit-special) instead
  (setq org-latex-preview-mode-display-live t)

  ;; More immediate live-previews -- the default delay is 1 second
  (setq org-latex-preview-mode-update-delay 0.25)
  (setq org-latex-compiler "lualatex")
  (setq org-latex-packages-alist '(("" "amssymb" t ("lualatex" "xetex"))
                                   ("" "luatexja" t ("lualatex"))
                                   ("" "luatexja-fontspec" t ("lualatex"))))
  (setq org-latex-preview-preamble (concat org-latex-preview-preamble "\n" "\\setmainjfont{Source Han Sans CN}"))
  (setq org-latex-preview-process-precompile 'nil))
;; (setq org-latex-packages-alist '(
;; 				 ("" "ctex" t)
;; 				 ("" "amsmath" t)))

;; (add-to-list 'org-preview-latex-process-alist
;; 	     '(xelatex-ch
;; 	       :programs ("xelatex" "dvisvgm")
;; 	       :description "xdv > svg"
;; 	       :message "You need to install xelatex & dvisvgm"
;; 	       :image-input-type "xdv"
;; 	       :image-output-type "svg"
;; 	       :latex-compiler
;; 	       ("xelatex -no-pdf -interaction=nonstopmode -output-directory %o")
;; 	       :image-converter
;; 	       ("dvisvgm --page=1- -n -b min -c %S -o %B-%%9p.svg %f")))
;; (setq org-preview-latex-default-process 'xelatex-ch)
;;


(add-to-list 'org-preview-latex-process-alist
             '(lualatex-chinese
               :programs ("lualatex" "dvisvgm") ; 或 "convert" 用于 PNG 输出
               :description "支持中文的 LuaLaTeX (DVI 转 SVG)"
               :message "您需要安装 lualatex 和 dvisvgm (或 imagemagick)。"
               :image-input-type "dvi"
               :image-output-type "svg"
               :latex-header "\\documentclass[preview]{standalone}\n\\usepackage{luatexja-fontspec}\n\\setmainjfont{FandolSong}\n\\usepackage[usenames]{color}\n\\usepackage{amsmath}\n\\pagestyle{empty}"
               :latex-compiler ("%l -interaction nonstopmode -output-directory=%o %f")
               :image-converter ("dvisvgm --page=1- --optimize --clipjoin --relative --no-fonts -v3 --message='processing page {?pageno}: output written to {?svgpath}' --bbox=preview -o %B-%%9p.svg %f")))
;; 将此自定义进程设置为所有 LaTeX 预览的默认值
(setq org-latex-preview-process-default 'lualatex-chinese)

;; (add-hook 'org-mode-hook (lambda () (delete 'company-dabbrev company-backends))) 
(defun my/org-company-backends-setup ()
  (setq-local company-backends
  (delete 'company-dabbrev (copy-sequence company-backends))))
(add-hook 'org-mode-hook #'my/org-company-backends-setup)
;; (add-hook 'pdf-tools-enabled-hook '(display-line-numbers-mode -1))
(add-hook 'pdf-tools-enabled-hook (lambda () (display-line-numbers-mode -1)))
(provide 'org-mode-setting)
;;; org-mode-setting.el ends here
