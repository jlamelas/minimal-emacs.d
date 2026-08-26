;;; pre-early-init.el --- Configuracións ao inicio do early-ini -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;; Este ficheiro cárgase tras a definición de varias funcións e variables ao
;; inicio do `early-init-file'.

;;; Code:

;; Inicia o frame maximizado
(push '(fullscreen . maximized) default-frame-alist)

;; Elementos da UI que debe cagar minimal-emacs
(setq minimal-emacs-ui-features '(menu-bar))

;; Redireccionar ficheiros variables para manter a raíz limpa
(setq user-emacs-directory (expand-file-name "var/" minimal-emacs-user-directory))
(setq package-user-dir (expand-file-name "elpa/"  user-emacs-directory))

;; Cargar carpeta lisp no `load-path'
(defconst jla-lisp-dir (expand-file-name "lisp/" minimal-emacs-user-directory)
  "Directorio para as configuracións específicas de Emacs.")

;; Comprobación de seguridade
(unless (file-directory-p jla-lisp-dir)
  (error "ERRO: O directorio %s non existe, créao e move todos os ficheiros init-*.el a el" jla-lisp-dir))

(add-to-list 'load-path (directory-file-name jla-lisp-dir))

;; Cargamos utilidades
(condition-case err
    (progn
      (require 'init-utils))
  (error
   (message "Erro ao cargar o ficheiro %s" err)))

;;; pre-early-init.el ends here
