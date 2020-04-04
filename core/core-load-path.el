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

;; ▶ appearance directory.
(defvar layer-appearance-dir (expand-file-name "+appearance/packages.el" emacs-layers-dir)
  "This directory Appearance directory.")

;; ▶ Editor Directory.
(defvar layer-editor-dir (expand-file-name "+editor/packages.el" emacs-layers-dir)
  "This Directory Editor.")

;; ▶ Performance tunning  Directory.
(defvar layer-performance-dir (expand-file-name "+performance/packages.el" emacs-layers-dir)
  "This Directory performance tunning.")

;; ▶ add appearance path init.
(defun emacs/load-appearance-path ()
  "emacs theme layer directory load path."
  (load-file layer-appearance-dir)
  (appearance/init))

;; ▶ add editor path init
(defun emacs/load-editor-dir ()
  "emacs editor directory load path."
  (load-file layer-editor-dir)
;;  (load-file layer-editor-nlinum-dir)
  (editor/init))

;; add performance path init
(defun emacs/performance-dir ()
  "emacs performance directory load path."
  (load-file layer-performance-dir))

(defun emacs/load-path-init ()
  " Defined Directory default init."
  ;; VersionControl init
  ;;(emacs/layer-version-control-path)
  ;; Appearance init
  ;;(emacs/load-appearance-path)
  ;; Editor init
  (emacs/load-editor-dir)
  (emacs/performance-dir)
  ;; emacs tags init
  ;;(emacs/load-tags-dir)
  ;; Build/debugger init
  ;;(emacs/load-debug-dir)
  ;; helm-imenu
  ;;(emacs/load-tools-dir)
  )

(provide 'core-load-path)
