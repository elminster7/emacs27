;; Coding System Read File encoding.

(modify-coding-system-alist 'file "\\.*\\'" 'utf-8)
(setq coding-system-for-read 'utf-8)

;;--------------------------------- Function-args
;; https://github.com/abo-abo/function-args
(fa-config-default)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
(set-default 'semantic-case-fold t)

;; yes or no -> y or n
(fset 'yes-or-no-p 'y-or-n-p)

;;--------------------------------- Edit
(add-hook 'after-init-hook 'global-company-mode)

;;--------------------------------- Layout for ecb-layout
(setq ecb-tip-of-the-day nil)

;;--------------------------------- Dired
;; latest file list
(setq dired-listing-switches "-alhF")

;;--------------------------------- Dired+
;;copy another frame command.
;;(setq dired-dwim-any-frame-flag t)
(setq dired-dwim-target t)
;;--------------------------------- ansi-term
(add-hook 'term-mode-hook (lambda()
                            (setq yas-dont-activate t)))

(provide 'core-editor)
