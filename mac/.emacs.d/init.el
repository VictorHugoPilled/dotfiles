;; emacs housekeeping
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq warning-minimum-level :emergency)

;; don't ask for confirmation when opening symlinked file
(setq vc-follow-symlinks t)     

(setq inhibit-startup-message t)
(setq dired-kill-when-opening-new-dired-buffer t)


(setq create-lockfiles nil)

(defun goto-init-file ()
  "Open the init file."
  (interactive)
  (find-file user-init-file))

;; fast quit
(defun my-kill-emacs ()
  "save some buffers, then exit unconditionally"
  (interactive)
  (save-some-buffers nil t)
  (kill-emacs))
(global-set-key (kbd "C-x C-c") 'my-kill-emacs)

;; package management
(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")))


;; setup use-package
(use-package use-package-ensure-system-package :ensure t)
(use-package exec-path-from-shell
  :ensure t)
;; necessary to get packages to install on mac
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


;; directory load custom packages from
;;(add-to-list 'load-path "~/.emacs.d/custom-packages")

;; only load rust-mode when needed
(use-package rust-mode
  :defer t)

;; bind spray mode f6
(use-package spray
  :bind ("[f6]" . spray-mode))

;; org-mode settings
;; autosave on TODO state chan ge
(use-package org
  :hook (org-trigger . save-buffer)
  :custom
  (org-todo-keywords
   '((sequence "TODO(t!)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
  (org-treat-insert-todo-heading-as-state-change t "log TODO creation")
  (org-log-into-drawer "LOGBOOK" "log into LOGBOOK drawer")
  )
  


;; add habits to org-modules
(add-to-list 'org-modules "org-habit")


;; org-pomodoro
(use-package org-pomodoro
  :ensure t
  :commands (org-pomodoro)
  :bind ("M-C-p" . org-pomodoro)
  ;; autosave on pomodorro finish
  :hook (org-pomodoro-finished . save-buffer)  
  :custom
   (org-pomodoro-length 20)
   (org-pomodoro-short-break-length 5)
   (org-pomodoro-clock-break t)
   (org-pomodoro-long-break-length 15)
   (org-pomodoro-manual-break t)
   )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-pomodoro use-package-ensure-system-package spray rust-mode exec-path-from-shell codespaces)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
