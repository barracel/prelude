(global-set-key "\C-x\C-m" 'execute-extended-command)
; (disable-theme 'zenburn)
; (global-set-key "\C-c\C-m" 'execute-extended-command)

(defun unix-werase-or-kill (arg)
  (interactive "*p")
  (if (and transient-mark-mode
           mark-active)
      (kill-region (region-beginning) (region-end))
    (backward-kill-word arg)))
(global-set-key "\C-w" 'unix-werase-or-kill)
; (global-set-key "\C-w" 'backward-kill-word)
; (global-set-key "\C-x\C-k" 'kill-region)
; (global-set-key "\C-c\C-k" 'kill-region)

; (load-theme 'solarized-ligth t)
; projectile settings
(setq projectile-show-paths-function 'projectile-hashify-with-relative-paths)
;(setq projectile-completion-system 'default)

(prelude-ensure-module-deps '(elpy))

(package-initialize)
(elpy-enable)
(elpy-use-ipython)
(highlight-indentation-mode)
(desktop-save-mode 1)

(defun barracel-elpy-use-ipython ()
  "Set defaults to use IPython instead of the standard interpreter."
  (interactive)
  (if (boundp 'python-python-command)
      ;; Emacs 24 until 24.3
      (setq python-python-command "ipython")
    ;; Emacs 24.3 and onwards.

    ;; This is from the python.el commentary.
    ;; Settings for IPython 0.11:
    (setq python-shell-interpreter "ipython"
          python-shell-interpreter-args ""
          python-shell-prompt-regexp "In \\[[0-9]+\\]: "
          python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
          python-shell-completion-string-code  "';'.join(__IP.complete('''%s'''))\n"
          python-shell-completion-module-string-code "")))

;(barracel-elpy-use-ipython)


; (require 'pc-bufsw)
; (pc-bufsw::bind-keys [C-tab] [C-S-tab])

; zenburn is not handling correctly colors in lucid
; (setq ansi-term-color-vector [unspecified "#3f3f3f" "#cc9393" "#7f9f7f" "#f0dfaf" "#8cd0d3" "#dc8cc3" "#93e0e3" "#dcdccc"])

; I don't like zenburn region color
(set-face-background 'region "#656555")

;; Some custom configuration to ediff
(defvar my-ediff-bwin-config nil "Window configuration before ediff.")
(defcustom my-ediff-bwin-reg ?b
  "*Register to be set up to hold `my-ediff-bwin-config'
configuration.")

(defvar my-ediff-awin-config nil "Window configuration after ediff.")
(defcustom my-ediff-awin-reg ?e
  "*Register to be used to hold `my-ediff-awin-config' window
configuration.")

(defun my-ediff-bsh ()
  "Function to be called before any buffers or window setup for
ediff."
  (setq my-ediff-bwin-config (current-window-configuration))
  (when (characterp my-ediff-bwin-reg)
    (set-register my-ediff-bwin-reg
                  (list my-ediff-bwin-config (point-marker)))))

(defun my-ediff-ash ()
  "Function to be called after buffers and window setup for ediff."
  (setq my-ediff-awin-config (current-window-configuration))
  (when (characterp my-ediff-awin-reg)
    (set-register my-ediff-awin-reg
                  (list my-ediff-awin-config (point-marker)))))

(defun my-ediff-qh ()
  "Function to be called when ediff quits."
  (when my-ediff-bwin-config
    (set-window-configuration my-ediff-bwin-config)))

(add-hook 'ediff-before-setup-hook 'my-ediff-bsh)
(add-hook 'ediff-after-setup-windows-hook 'my-ediff-ash 'append)
(add-hook 'ediff-quit-hook 'my-ediff-qh)


(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key "\C-a" 'smart-beginning-of-line)

(scroll-bar-mode -1)

(defun goto-line-with-feedback (&optional line)
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive "P")
  (if line
      (goto-line line)
    (unwind-protect
        (progn
          (linum-mode 1)
          (goto-line (read-number "Goto line: ")))
      (linum-mode -1))))

;; or replace all goto-line
(global-set-key (vector 'remap 'goto-line) 'goto-line-with-feedback)

;; Toggle between split windows and a single window
(defun toggle-windows-split()
  "Switch back and forth between one window and whatever split of
windows we might have in the frame. The idea is to maximize the
current buffer, while being able to go back to the previous split
of windows in the frame simply by calling this command again."
  (interactive)
  (if (not (window-minibuffer-p (selected-window)))
      (progn
        (if (< 1 (count-windows))
            (progn
              (window-configuration-to-register ?u)
              (delete-other-windows))
          (jump-to-register ?u)))))

(define-key global-map (kbd "C-x |") 'toggle-windows-split)

;; Use shell-like backspace C-h, rebind help to F1
(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "<f1>") 'help-command)

(global-set-key (kbd "M-h") 'kill-region-or-backward-word)
