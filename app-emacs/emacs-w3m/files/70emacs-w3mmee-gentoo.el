
;;; emacs-w3m site-lisp configuration

(add-to-list 'load-path "@SITELISP@")

(setq w3m-command "/usr/bin/w3mmee")

(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-browse-url "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-find-file "w3m" "w3m interface function for local file." t)
(autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH-ENGINE." t)
(autoload 'w3m-weather "w3m-weather" "Display weather report." t)
(autoload 'w3m-antenna "w3m-antenna" "Report chenge of WEB sites." t)
(autoload 'w3m-namazu "w3m-namazu" "Search files with Namazu." t)

(setq w3m-icon-directory "/usr/share/emacs-w3m/icon")

