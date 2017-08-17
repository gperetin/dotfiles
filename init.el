(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil popup-imenu counsel ivy fzf projectile which-key ensime use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; My config

;; global variables
(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 column-number-mode t
 scroll-error-top-bottom t
 show-paren-delay 0.5
 use-package-always-ensure t
 sentence-end-double-space nil)

;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

;; Store backups in a common folder + keep lots of history
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; Configure history
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; Automatically indent after RET
(electric-indent-mode +1)

;; global keybindings
(global-unset-key (kbd "C-z"))

;; the package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package scala-mode
  :pin melpa)

; (setq default-frame-alist '((font . "Iosevka Term-18")))
(setq default-frame-alist '((font . "Source Code Pro-18")))

;; Get some screen realestate back
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Don't want blinking
(blink-cursor-mode 0)

;; Some random stuff
(show-paren-mode)
(setq sentence-end-double-space nil)
(fset 'yes-or-no-p 'y-or-n-p)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(defalias 'list-buffers 'ibuffer)

; Which key
(which-key-mode)

; Disable all bells
(setq ring-bell-function 'ignore)

; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))

(setq projectile-enable-caching t)

; Swiper, counsel and ivy
(use-package counsel
  :ensure t)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

; Tune GC
(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 8000000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

; Showing git branch in modeline on file open is slow, let's remove that hook
(remove-hook 'find-file-hook 'vc-refresh-state)

; Faster fuzzy file search
(define-key evil-normal-state-map ",f" 'counsel-git)
(define-key evil-normal-state-map ",b" 'ivy-switch-buffer)

;; Rust config
(use-package rust-mode
  :ensure t)

;; YAML mode
(use-package yaml-mode
  :ensure t
  :pin melpa)
(yaml-mode)

;; Smart mode line package
(use-package smart-mode-line
  :ensure t)

;; Load Twitter custom config and don't bark if it's not there
(load "~/.emacs.d/custom_configs/twitter.el" t)

;; Solarized theme
(use-package solarized-theme
  :ensure t)
(load-theme 'solarized-light)
(setq solarized-use-less-bold t)

;; Nicer bullets for Org mode
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Key chords
(use-package key-chord
  :ensure t
  :pin melpa)
(require 'key-chord)

;; Max time delay between two key presses to be considered a key chord
(setq key-chord-two-keys-delay 0.1) ; default 0.1

;; Max time delay between two presses of the same key to be considered a key chord.
;; Should normally be a little longer than `key-chord-two-keys-delay'.
(setq key-chord-one-key-delay 0.3) ; default 0.2

(defun switch-to-previous-buffer ()
    "Switch to previously open buffer.
    Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(key-chord-define-global ",," 'switch-to-previous-buffer)
(key-chord-mode +1)
