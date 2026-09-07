;;; package --- tt66ea-typst
;;; Commentary:
;;; Code:

;; == typst-ts-mode == (MELPA, tree-sitter 语法高亮)
(use-package typst-ts-mode
  :ensure t
  :mode "\\.typ\\'"
  :hook (typst-ts-mode . eglot-ensure)
  :custom
  (typst-ts-mode-indent-offset 2)
  :config
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 `((typst-ts-mode) .
                   ,(eglot-alternatives
                     '("tinymist" "typst-lsp"))))))

;; == typst-preview == (MELPA, 实时预览 via msedge --app)
(use-package typst-preview
  :ensure t
  :after typst-ts-mode
  :custom
  (typst-preview-invert-colors "auto")
  (typst-preview-partial-rendering t)
  :config
  (defun my/typst-preview-browse-url (url &rest _)
    "Open URL with Edge app window for typst preview."
    (let ((edge-path (or (executable-find "msedge")
                         (and (file-executable-p "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe")
                              "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe")
                         (and (file-executable-p "C:/Program Files/Microsoft/Edge/Application/msedge.exe")
                              "C:/Program Files/Microsoft/Edge/Application/msedge.exe"))))
      (if edge-path
          (start-process "typst-preview-edge" nil
                         edge-path "--app" "--new-window" url)
        (browse-url-default-browser url))))
  (add-hook 'typst-preview-mode-hook
            (lambda ()
              (setq-local browse-url-browser-function
                          #'my/typst-preview-browse-url)))
  (define-key typst-preview-mode-map
              (kbd "C-c C-j") #'typst-preview-send-position))

;; == prettify-symbols-mode == (内置, 自动符号替换)
(defvar typst-prettify-alist
  '(("->"   . ?→)
    ("<-"   . ?←)
    ("=>"   . ?⇒)
    ("<="   . ?≤)
    (">="   . ?≥)
    ("!="   . ?≠)
    ("-->"  . ?⟶)
    ("<--"  . ?⟵)
    ("|->"  . ?↦)
    ("\\in"        . ?∈)
    ("\\notin"     . ?∉)
    ("\\subseteq"  . ?⊆)
    ("\\subset"    . ?⊂)
    ("\\supset"    . ?⊃)
    ("\\forall"    . ?∀)
    ("\\exists"    . ?∃)
    ("\\times"     . ?×)
    ("\\cdot"      . ?·)
    ("\\alpha"     . ?α)
    ("\\beta"      . ?β)
    ("\\gamma"     . ?γ)
    ("\\delta"     . ?δ)
    ("\\epsilon"   . ?ε)
    ("\\theta"     . ?θ)
    ("\\lambda"    . ?λ)
    ("\\mu"        . ?μ)
    ("\\pi"        . ?π)
    ("\\sigma"     . ?σ)
    ("\\omega"     . ?ω)
    ("\\Pi"        . ?Π)
    ("\\Sigma"     . ?Σ)
    ("\\Omega"     . ?Ω)
    ("\\inf"       . ?∞)
    ("\\sum"       . ?∑)
    ("\\prod"      . ?∏)
    ("\\int"       . ?∫))
  "Typst prettify-symbols alist.")

(add-hook 'typst-ts-mode-hook
          (lambda ()
            (setq-local prettify-symbols-alist typst-prettify-alist)
            (prettify-symbols-mode 1)))

(provide 'typst)
;;; typst.el ends here
