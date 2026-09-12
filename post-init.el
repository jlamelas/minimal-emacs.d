;;; post-init-el --- Configuracións post init -*- no-byte-compile: t; lexical-binding: t; -*-

;;;; Commentary:

;; Configuracións post ficheiro init.el

;;; Code:

;; Cargamos ficheiros de configuración
(condition-case err
    (progn
      (message "Cargando init-ui.el.")
      (require 'init-ui)
      (message "Cargando init-core.el.")
      (require 'init-core)
      (message "Cargando init-cmpletion.el.")
      (require 'init-completion)
      (message "Cargando init-org.el.")
      (require 'init-org)
      (message "Cargando init-dev.el.")
      (require 'init-dev)
      (message "Cargando init-ai.el.")
      (require 'init-ai)
      (message "Cargando init-games.el.")
      (require 'init-games))
  (error
   (let* ((file (car (cdr (cdr err))))
          (line (car (cdr (cdr (cdr err)))))
          (message (format "Erro ao cargar o ficheiro %s na liña %s. Detalle do erro: %s"
                           (or file "descoñecido") (or line "descoñecida") err)))
     (message message))))

;;; post-init.el ends here
