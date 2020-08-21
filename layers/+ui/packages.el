(defun ui/vsdark-theme ()
  "vsdark+ theme init"
  (use-package vscdark-theme
    :ensure t
    ))

(defun ui/spacemacs-theme ()
  "spaceemacs theme init"
  (use-package spacemacs-theme
    :ensure t
    ))

(defun ui/powerline-evil ()
  "powerline evil init"
  (use-package powerline-evil
    :ensure t
    :config (powerline-evil-center-color-theme)))

;; editor ui init
(defun ui/function_init ()
  "ui preference settings init"
; (ui/spacemacs-theme)
  (ui/powerline-evil))

(defun ui/init ()
  (ui/function_init))
