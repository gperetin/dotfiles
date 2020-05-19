;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Goran Peretin"
      user-mail-address "goran.peretin@gmail.com")

(setq org-list-indent-offset 1)
(load! "lisp/org-variable-pitch.el")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; test
;; (setq doom-font (font-spec :family "Bitstream Vera Sans Mono" :size 16)
(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 18)
      doom-variable-pitch-font (font-spec :family "Inter" :size 16)
      doom-serif-font (font-spec :family "Bitstream Vera Sans" :size 18))

;; See here on what can be specified here
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Face-Attributes.html#Face-Attributes
(custom-theme-set-faces
 'user
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-link ((t (:inherit variable-pitch :weight normal :underline t :foreground "#5fd7ff"))))
 '(org-level-1 ((t (:inherit variable-pitch :weight bold :height 1.2 :foreground "#d7afff"))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch)))))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-tomorrow-day)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


;; Goran's customization from here down

(setq org-directory "~/Notes")
(setq org-default-notes-file "~/Notes/inbox.org")

;; Attach a timestamp when a TODO item is market done
(setq org-log-done 'time)

; (after! org
(use-package! org-roam
  :hook
  (after-init . org-roam-mode)
  :custom-face
  (org-roam-link ((t (:inherit org-link :foreground "lime green" :weight normal :slant italic))))
  :init
  (map!
   "C-c n l" #'org-roam
   "C-c n t" #'org-roam-today
   "C-c n f" #'org-roam-find-file
   "C-c n i" #'org-roam-insert
   "C-c n g" #'org-roam-show-graph
   )
  (setq org-roam-directory "~/Notes/roam")
  :config
  (setq org-roam-capture-templates
       '(("d" "default" plain (function org-roam--capture-get-point)
             "%?"
             :file-name "%<%Y%m%d%H%M%S>-${slug}"
             :head "#+TITLE: ${title}\n#+CREATED_AT: %<%Y-%m-%d>\n#+ROAM_TAGS:\n"
             :unnarrowed t)))
  (org-roam-mode +1))

(setq org-superstar-headline-bullets-list '("◉" "○" "" ""))

; (add-hook 'org-mode-hook 'variable-pitch-mode)
(setq display-line-numbers-type nil)

(add-hook 'org-mode-hook (lambda ()
                             (setq line-spacing 0.1)))

(add-hook 'org-mode-hook 'org-variable-pitch-minor-mode)

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

; (progn
;   ;; use variable-width font for some modes
;   (defun use-variable-width-font ()
;     "Set current buffer to use variable-width font."
;     (variable-pitch-mode 1)
;     ;; (text-scale-increase 1 )
;     )
;   (add-hook 'org-mode-hook 'use-variable-width-font))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
