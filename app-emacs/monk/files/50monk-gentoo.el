
;;; monk site-lisp configuration

(autoload 'monk "monk" nil t)

(autoload 'monk-open-new "monk" nil t)
(autoload 'monk-other-window "monk" nil t)
(autoload 'monk-other-frame "monk" nil t)

;; If you need volume control
(setq monk-volume-command "aumix")

;; Mouse bindings some more (to HipHop on the mode-line)
(add-hook 'monk-load-hook 'monk-use-extra-mouse)

;; Enable M-m (monk-dired-do-monk), and
;;        M-C-m (monk-dired-do-monk-find-file) in dired
;; See also "Howto use monk-dired keyboard commands" section
;; in monk.el.
(autoload  'monk-dired-bind-extra-keys "monk" nil t)
(add-hook 'dired-load-hook 'monk-dired-bind-extra-keys)
;; dired *must* be loaded *after* this.

;; I prefer this for M-m (monk-dired-do-monk) command in `dired'
(setq monk-dired-monk-command 'monk-other-window)

;; If you want to use remote cddb server to display track titles
;; when cdda2wav can't generate the track/album titles.
;; See monk-cddb script for detail.
(setq monk-use-cddb-server t)

;; To check CD media is in the drive (requires cdparanoia(1))
(setq monk-dont-care-no-CD nil)

;; In order to make the track timer work for MIDI track 
(setq monk-midi-probe-command "timidity")

;; If menu-bar entry is required from the start
                (let ((fmenu (or (lookup-key global-map [menu-bar tools])
                                 (lookup-key global-map [menu-bar file]))))
                  (define-key-after fmenu [monk]
                    ;; '("MonK" . monk) ;; This is the same setup in monk.el
                    '("MonK" . monk-open-new) ;; monks may like this
                    'calendar)
                  (x-popup-menu nil fmenu))

;; Use `face' display for current playing track
(setq monk-use-face t)
;; Some examples of faces on emacs running as X client
;; (All of these may not available on your emacs):
;; 
;; ;; (setq monk-current-track-X-face-prop 'RoyalBlue)
;; (progn
;;   (load "cus-edit")
;; ;; (setq monk-current-track-X-face-prop 'custom-invalid-face)
;;  (setq monk-current-track-X-face-prop 'custom-set-face)
;;  )



