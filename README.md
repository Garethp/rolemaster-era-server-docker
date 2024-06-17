# Rolemaster ERA Server

This is a small docker container to host the Linux version of the Rolemaster ERA Software as a server using Docker

## Required Steps

1. Mount the `ERA-Linux` folder to `/srv/ERA-Linux` so that the container can run the ERA
2. Mount a folder to store Server Side Character Sheets to `/srv/Characters`
3. Define the environment variable `MODULE` to be the module that you want to run, IE: `MODULE=Privateers`. This module must exist as a subfolder inside `ERA-Linux`

## Optional Extra Modules

If you want to have extra modules with more content available, you need to mount the modules and then define an environment variable stating which ones you want to load. The loading is done by copying all the files inside the module folder into the root of your `ERA-Linux` folder and will overwrite existing files if they share a similar name.

1. Mount a folder containing all of your extra module folders to `/srv/Modules`. Modules in this folder will not be loaded unless they are defined in `EXTRA_MODULES`.
2. Define the environment variable `EXTRA_MODULES` to be a list of the modules from `/srv/Modules` separated by a semi-colon. For example, `EXTRA_MODULES=Privateers-Core;Custom-Module` will copy the contents of `srv/Modules/Privateers-Core` and `/srv/Modules/Custom-Module` into a working copy of `ERA-Linux` before starting the server