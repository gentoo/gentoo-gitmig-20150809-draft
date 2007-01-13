# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config/files/java-config-2.profiled.csh,v 1.2 2007/01/13 16:36:54 betelgeuse Exp $

set gentoo_user_vm="${HOME}/.gentoo/java-config-2/current-user-vm"
set gentoo_system_vm="/etc/java-config-2/current-system-vm"

## If we have a current-user-vm (and aren't root)... set it to JAVA_HOME
## Otherwise set to the current system vm
if (($uid != "0") && (-l $gentoo_user_vm)) then
    setenv JAVA_HOME $gentoo_user_vm
else if (-l $gentoo_system_vm) then
    setenv JAVA_HOME $gentoo_system_vm
endif

setenv JDK_HOME $JAVA_HOME
setenv JAVAC ${JDK_HOME}/bin/javac
unset gentoo_user_vm gentoo_system_vm

