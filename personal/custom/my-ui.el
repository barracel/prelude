; zenburn region color has too low contrast for my taste
(set-face-background 'region "#656555")

(desktop-save-mode 1)
(scroll-bar-mode -1)

; zenburn is not handling correctly colors in my lucid's emacs
( if (string-equal (shell-command-to-string "lsb_release -cs") "lucid\n")
    (setq ansi-term-color-vector [unspecified "#3f3f3f" "#cc9393" "#7f9f7f" "#f0dfaf" "#8cd0d3" "#dc8cc3" "#93e0e3" "#dcdccc"])
)

