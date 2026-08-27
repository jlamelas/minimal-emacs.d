;;; post-init-el --- Configuracións post init -*- no-byte-compile: t; lexical-binding: t; -*-

;;;; Commentary:

;; Configuracións post ficheiro init.el

;;; Code:

;; Cargamos ficheiros de configuración
(condition-case err
    (progn
      (require 'init-ui)
      (require 'init-core)
      (require 'init-completion)
      (require 'init-dev))
  (error
   (message "Erro ao cargar o ficheiro %s" err)))


;;; post-init.el ends here
