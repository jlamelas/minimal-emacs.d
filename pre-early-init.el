;;; pre-early-init.el --- This file is loaded before early-init.el -*- no-byte-compile: t; lexical-binding: t; -*-

;; UI configurations
(setq minimal-emacs-ui-features '(context-menu menu-bar dialogs tooltips))

;;; Reducing clutter in ~/.emacs.d by redirecting files to ~/.emacs.d/var/
(setq user-emacs-directory (expand-file-name "var/" minimal-emacs-user-directory))
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
