;;; jla.el --- Personal custom variables and functions -*- no-byte-compile: t; lexical-binding: t; -*-

(defgroup jla()
  "Personal custom variables and functions.")

(defcustom jla/hunspell-dictionaries "gl_ES,es_ES,en_GB"
  "Comma separated list of Hunspell dictionaries."
  :group 'jla
  :type 'list)

;; set the endpoint for the ollama server
(defcustom jla/ollama-api-endpoint "http://localhost:11434"
  "The URL for ollama server API endpoint."
  :group 'jla-gptel-options
  :type 'string)

(defun jla/get-ollama-models ()
  "Return a list of Ollama models from the API, or nil if the API is not available."
  (when-let*
      ((url (url-generic-parse-url jla/ollama-api-endpoint))
       (host (url-host url))
       (port (url-port url))
       ;; Use short timeout with curl to assure API port is open
       (maybe-ollama-models (split-string (shell-command-to-string
					                       (concat "curl -s --connect-timeout 0.5 '"
						                           jla/ollama-api-endpoint "/api/tags' | jq -r '.models[].name'")) "\n" t))
       (my-ollama-models (seq-filter (lambda (s) (not (string= s "")))
                                     maybe-ollama-models)))
    my-ollama-models))

(defun jla/get-github-models ()
  "Return a list of GitHub models from the API, nil if the API is not available."
  (when-let*
      ((maybe-github-models (split-string (shell-command-to-string
                                           (concat "curl -X GET -s --connect-timeout 0.5 'https://models.inference.ai.azure.com/models' | jq -r '.[].name'")) "\n" t))
       (my-github-models (seq-filter (lambda (s) (not (string= s "")))
                                     maybe-github-models)))
    my-github-models))

(defvar jla/gptel-search-prefix
  (if (and (boundp 'eww-search-prefix) eww-search-prefix) eww-search-prefix "https://duckduckgo.com/html?q=")
  "Base URL used for searching the web using gptel tools.
Falls back to duckduckgo if EWW is not loaded.")

(defun jla/search-web (query)
  "Initiate a web search using the search engine defined in `jla/gptel-search-prefix' using QUERY."
  (condition-case err
      (let* ((url-with-query
              (url-encode-url (concat jla/gptel-search-prefix query)))
             (content (shell-command-to-string
                       (format "lynx -dump -list_inline '%s'" url-with-query))))
        (format "Content pulled from %s\n\n%s" query content))
    (warning (format "Error accessing %s: %s" query (error-message-string err)))))


(defun jla/read-web (url)
  "Pull in a web page from URL with plain text and links."
  (condition-case err
      (let ((content (shell-command-to-string
                      (format "lynx -dump -list_inline %s" url))))
        (format "Content pulled from %s\n\n%s" url content))
    (warning (format "Error accessing %s: %s" url (error-message-string err)))))

(provide 'jla)

;;; jla.el ends here
