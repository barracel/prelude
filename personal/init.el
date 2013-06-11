; projectile settings
(setq projectile-show-paths-function 'projectile-hashify-with-relative-paths)

; extra packages
(prelude-ensure-module-deps '(elpy))


(setq my-lib-dir (expand-file-name "lib" prelude-personal-dir))
(setq my-custom-dir (expand-file-name "custom" prelude-personal-dir))

(add-to-list 'load-path my-lib-dir)

(mapc 'load (directory-files my-custom-dir 't "^[^#].*el$"))



