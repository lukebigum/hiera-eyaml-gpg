#!/bin/bash

gem uninstall hiera-eyaml-gpg-native
rake build
gem install pkg/hiera-eyaml-gpg-native
eyaml -v
