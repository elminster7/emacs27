;;
;; emacs first load path
;;

(defvar emacs-start-directory
  user-emacs-directory
  "emacs start directory.")

(defvar emacs-core-directory
  (expand-file-name (concat emacs-start-directory "core/"))
  "emacs core directory.")

;; ▶ ex) Appearance, VersionControl, Editor, Build, Tools... etc
(defvar emacs-layers-dir (expand-file-name "layers" emacs-dir)
  " This directory is divide to package.")

;; ▶ Editor directory.
(defvar layer-editor-dir (expand-file-name "+editor/packages.el" emacs-layers-dir)
  "This Directory Editor.")

;; ▶ Performance tunning  directory.
(defvar layer-performance-dir (expand-file-name "+performance/packages.el" emacs-layers-dir)
  "This Directory performance tunning.")

;; ▶ completion  directory.
(defvar layer-completion-dir (expand-file-name "+completion/packages.el" emacs-layers-dir)
  "This Directory performance tunning.")

;; ▶ completion  directory.
(defvar layer-tools-dir (expand-file-name "+tools/packages.el" emacs-layers-dir)
  "This Directory performance tunning.")

;; ▶ ui directory.
(defvar layer-ui-dir (expand-file-name "+ui/packages.el" emacs-layers-dir)
  "This Directory performance tunning.")

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; ▶ add appearance path init.
(defun emacs/load-appearance-path ()
  "emacs theme layer directory load path."
  (load-file layer-appearance-dir)
  (appearance/init))

;; ▶ add editor path init
(defun emacs/load-editor-dir ()
  "emacs editor directory load path."
  (load-file layer-editor-dir)
  (editor/init))

;; add performance path init
(defun emacs/load-performance-dir ()
  "emacs performance directory load path."
  (load-file layer-performance-dir)
  (performance/init))

;; add completion dir.
(defun emacs/load-completion-dir ()
  "emacs performance directory load path."
  (load-file layer-completion-dir)
  (completion/init))

;; add tool dir.
(defun emacs/load-tools-dir ()
  "emacs performance directory load path."
  (load-file layer-tools-dir)
  (tools/init))

;; add ui dir.
(defun emacs/load-ui-dir ()
  "emacs ui directory load path."
  (load-file layer-ui-dir)
  (ui/init))

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun emacs/load-path-init ()
  " Defined Directory default init."
  (emacs/load-editor-dir)
  (emacs/load-completion-dir)
  (emacs/load-tools-dir)
  (emacs/load-performance-dir)
  (emacs/load-ui-dir))

(provide 'core-load-path)
