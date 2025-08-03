;;; pre-early-init.el --- This file is loaded before early-init.el -*- no-byte-compile: t; lexical-binding: t; -*-

;; UI configurations
(setq minimal-emacs-ui-features '(context-menu menu-bar dialogs tooltips))

(defun maybe-create-symlink-relative (filename link)
  "Crea unha ligazón simbólica de FILENAME no directorio actual a LINK.
FILENAME: O nome do ficheiro a ligar no directorio actual.
LINK: O destino da ligazón simbólica."
  (let ((target (concat default-directory filename))
        (link-dir (file-name-directory link)))
    (unless (file-exists-p link) ; Primeiro verificar se a ligazón existe.
      (unless (file-exists-p link-dir)
        (make-directory link-dir t))  ; Crea os directorios pais se non existen.
      (make-symbolic-link target link))))


;;; Reducing clutter in ~/.emacs.d by redirecting files to ~/.emacs.d/var/
(setq user-emacs-directory (expand-file-name "var/" minimal-emacs-user-directory))
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(maybe-create-symlink-relative "jla.el" (concat (expand-file-name "jla/" user-emacs-directory) "jla.el"))
(add-to-list 'load-path (expand-file-name "jla" user-emacs-directory))

;;; pre-early-init ends here

