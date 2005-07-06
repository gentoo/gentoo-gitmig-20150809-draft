# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/java.eclass,v 1.21 2005/07/06 20:20:03 agriffis Exp $
#
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>

inherit eutils

INHERITED="$INHERITED $ECLASS"
DESCRIPTION="Based on the $ECLASS eclass"

VMHANDLE=${PN}-${PV}

EXPORT_FUNCTIONS pkg_postinst pkg_prerm

java_pkg_postinst() {
	local jdk=${PN#*-}
	if [ ${jdk:0:3} == "jdk" ]; then
		java_set_default_vm_
	else
		# Only install the JRE as the system default if there's no JDK
		# installed. Installing a JRE over an existing JDK will result
		# in major breakage, see #9289.
		if [ ! -f "${JAVAC}" ]; then
			 ewarn "Found no JDK, setting ${VMHANDLE} as default system VM"
			java_set_default_vm_
	fi
	fi
	java_mozilla_clean_
}

java_pkg_prerm() {
	if java-config -J | grep -q ${P} ; then
		ewarn "It appears you are removing your default system VM!"
		ewarn "Please run java-config -L then java-config-S to set a new system VM!"
	fi
}

java_set_default_vm_() {
		java-config --set-system-vm=${VMHANDLE}
		/usr/sbin/env-update
		source /etc/profile

	echo
	einfo " After installing ${P} this"
	einfo " was set as the default JVM to run."
	einfo " When finished please run the following so your"
	einfo " enviroment gets updated."
	eerror "	/usr/sbin/env-update && source /etc/profile"
	einfo " Or use java-config program to set your preferred VM"
}

system_arch() {
	local sarch
	sarch=`echo $ARCH | sed -e s/[i]*.86/i386/ -e s/x86_64/amd64/ -e s/sun4u/sparc/ -e s/sparc64/sparc/ -e s/arm.*/arm/ -e s/sa110/arm/`
	if [ -z "$sarch" ] ; then
		sarch=`uname -m | sed -e s/[i]*.86/i386/ -e s/x86_64/amd64/ -e s/sun4u/sparc/ -e s/sparc64/sparc/ -e s/arm.*/arm/ -e s/sa110/arm/`
	fi
	echo $sarch
}

set_java_env() {
	dodir /etc/env.d/java
	platform=`system_arch`

	sed \
		-e "s/@P@/${P}/g" \
		-e "s/@PN@/${PN}/g" \
		-e "s/@PV@/${PV}/g" \
		-e "s/@PF@/${PF}/g" \
		-e "s/@PLATFORM@/${platform}/g" \
		-e "/^ADDLDPATH=.*lib\\/\\\"/s|\"\\(.*\\)\"|\"\\1${platform}/:\\1${platform}/server/\"|" \
		< $1 \
		> ${D}/etc/env.d/java/20`basename $1` || die
}


java_get_plugin_dir_() {
	echo /usr/$(get_libdir)/nsbrowser/plugins
}

install_mozilla_plugin() {
	if [ ! -f ${D}/$1 ] ; then
		die "Cannot find mozilla plugin at ${D}/${1}"
	fi

	local plugin_dir=$(java_get_plugin_dir_)
	dodir ${plugin_dir}
	dosym ${1} ${plugin_dir}/javaplugin.so
}

java_mozilla_clean_() {
	#Because previously some ebuilds installed symlinks outside of pkg_install
	#and are left behind, which forces you to manualy remove them to select the
	#jdk/jre you want to use for java
	local plugin_dir=$(java_get_plugin_dir_)
	for file in ${plugin_dir}/javaplugin_*; do
		rm -f ${file}
	done
	for file in ${plugin_dir}/libjavaplugin*; do
		rm -f ${file}
	done
}

