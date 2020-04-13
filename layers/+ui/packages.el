(defun ui/vsdark-theme ()
  "vsdark+ theme init"
  (use-package vscdark-theme
    :ensure t
    :init ((load-theme 'vscdark t))))

;; editor ui init
(defun ui/function_init ()
  "ui preference settings init"
  (ui/vsdark-theme))

(defun ui/init ()
  (ui/function_init))
