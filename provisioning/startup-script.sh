#! /bin/bash
# Copyright 2015 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# [START startup]
set -v

# Install dependencies from apt
apt-get update
apt-get install -yq nginx wget

# Create a webpage which takes the name of the HOSTNAME you configure
echo "<h1> Welcome on " $HOSTNAME " ! </h1>" > /var/www/html/index.html
# [END startup]
