;; packages.el --- tools packages for elminster.

;; lsp mode
(defun editor/lsp-mode ()
  "lsp packages"
  (use-package lsp-mode
    :defer t
    :commands lsp
    :custom
    (lsp-auto-guess-root t)
    (lsp-enable-snippet nil)
    (lsp-prefer-flymake nil) ; Use flycheck instead of flymake
    :bind (:map lsp-mode-map ("C-c C-f" . lsp-format-buffer))
    :hook ((python-mode c-mode c++-mode) . lsp)
    :config
    (setq lsp-prefer-flymake nil) ;; Prefer using lsp-ui (flycheck) over flymake.
    ))
  ;; :config (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error"))

(defun editor/lsp-ui ()
  "lsp mode"
  (use-package lsp-ui
    :requires lsp-mode flycheck
    :commands lsp-ui-mode
    :custom-face
    (lsp-ui-doc-background ((t (:background nil))))
    (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
    :bind (:map lsp-ui-mode-map
		([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
		([remap xref-find-references] . lsp-ui-peek-find-references)
		("C-c u" . lsp-ui-imenu))
    :hook (lsp-mode-hook . lsp-ui-mode)
    :custom
    (lsp-ui-doc-enable t)
    (lsp-ui-doc-use-childframe t)
    (lsp-ui-flycheck-enable t)
    (lsp-ui-flycheck-list-position 'right)
    (lsp-ui-flycheck-live-reporting t)
    (lsp-ui-peek-enable t)
    (lsp-ui-peek-list-width 60)
    (lsp-ui-peek-peek-height 25)
    (lsp-ui-doc-header t)
    (lsp-ui-doc-include-signature t)
    (lsp-ui-doc-position 'top)
    (lsp-ui-doc-border (face-foreground 'default))
    (lsp-ui-sideline-enable t)
    (lsp-ui-sideline-ignore-duplicate t)
    (lsp-ui-sideline-show-code-actions t)
    :config
    ;; Use lsp-ui-doc-webkit only in GUI
    (setq lsp-ui-doc-use-webkit nil)
    ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
    ;; emacs-lsp/lsp-ui#243
    (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
      (setq mode-line-format nil)))
  )

(defun tools/init ()
  (editor/lsp-mode)
  (editor/lsp-ui))
