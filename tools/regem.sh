#!/bin/bash

gem uninstall hiera-eyaml-gpg
rake build
gem install $(dirname $0)/../pkg/hiera-eyaml-gpg*.gem
eyaml -v
