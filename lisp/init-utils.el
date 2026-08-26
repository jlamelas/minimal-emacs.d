;;; init-utils.el --- Emacs Lisp utilities -* no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;; Variables e funcións útiles para a configuración de Emacs.

;;; Code:

;; Ruta do servidor local de Ollama
(defvar jla-ollama-api-endpoint "http://localhost:11434"
  "A URL para a API do servidor Ollama.")

(defun jla/get-ollama-models ()
  "Return a list of Ollama models from the API, or nil if the API is not available."
  (when-let*
      ((url (url-generic-parse-url jla-ollama-api-endpoint))
       (host (url-host url))
       (port (url-port url))
       ;; Use short timeout with curl to assure API port is open
       (maybe-ollama-models (split-string (shell-command-to-string
					                       (concat "curl -s --connect-timeout 0.5 '"
						                           jla-ollama-api-endpoint "/api/tags' | jq -r '.models[].name'")) "\n" t))
       (my-ollama-models (seq-filter (lambda (s) (not (string= s "")))
                                     maybe-ollama-models)))
    my-ollama-models))

(provide 'init-utils)

;;; init-utils.el ends here
