;;; pre-early-init.el --- Configuracións ao inicio do early-ini -*- lexical-binding: t; -*-

;;; Commentary:

;; Este ficheiro cárgase tras a definición de varias funcións e variables ao
;; inicio do `early-init-file'.

;;; Code:

;; Inicia o frame maximizado
(push '(fullscreen . maximazed) default-frame-alist)

;; Elementos da UI que debe cagar minimal-emacs
(setq minimal-emacs-ui-features '(menu-bar))

;; Redireccionar ficheiros variables para manter a raíz limpa
(setq user-emacs-directory (expand-file-name "var/" minimal-emacs-user-directory))
(setq package-user-dir (expand-file-name "elpa"  user-emacs-directory))

;;; pre-early-init.el ends here
