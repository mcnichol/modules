#!/usr/bin/env bash

source "../_common_scripts/config/styles.sh"
source "../_common_scripts/config/functions.sh"

THIS_PLATFORM=$(uname)
MEETS_DEPENDENCY_REQUIREMENTS=true


msgWithColor "Checking dependencies for $THIS_PLATFORM\n" $GREEN
# Dependencies
if [ $THIS_PLATFORM == "Darwin" ]; then

   xcode-select --version > /dev/null 2>&1
   if [ $? == "1" ]; then
      echo "Must have xcode installed"
      MEETS_DEPENDENCY_REQUIREMENTS=false
   fi

   program_is_installed brew
   if [ $? == "1" ]; then
      echo "Must have brew installed"
      MEETS_DEPENDENCY_REQUIREMENTS=false
   fi

   program_is_installed openssl
   if [ $? == "1" ]; then
      echo "Must have openssl installed"
      MEETS_DEPENDENCY_REQUIREMENTS=false
   fi

   program_is_installed ruby
   if [ $? == "1" ]; then
      echo "Must have ruby installed to continue"
      MEETS_DEPENDENCY_REQUIREMENTS=false
   fi
fi

# Ubuntu - Trusty Tar
#sudo apt-get update
# sudo apt-get install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt-dev libxml2-dev libssl-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3

# CentOS
#sudo yum install gcc gcc-c++ ruby ruby-devel mysql-devel postgresql-devel postgresql-libs sqlite-devel libxslt-devel libxml2-devel patch openssl
#gem install yajl-ruby



if [ $MEETS_DEPENDENCY_REQUIREMENTS ]; then
   msgWithColor "It looks like you have everything you need to start using bosh. Have fun!\n" $BLUE
else
   msgWithColor "Please install missing dependencies and check again\n" $RED
fi
