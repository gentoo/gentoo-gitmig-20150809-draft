# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/java-vm-2.eclass,v 1.3 2006/06/30 12:15:35 nichoj Exp $
#
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>

inherit eutils

DEPEND="
	=dev-java/java-config-2.0*
	=dev-java/java-config-1.3*"
RDEPEND="
	=dev-java/java-config-2.0*
	=dev-java/java-config-1.3*"

export WANT_JAVA_CONFIG=2

if [[ "${SLOT}" != "0" ]]; then
	VMHANDLE=${PN}-${SLOT}
else
	VMHANDLE=${PN}
fi

JAVA_VM_CONFIG_DIR="/usr/share/java-config-2/vm"
JAVA_VM_DIR="/usr/lib/jvm"

EXPORT_FUNCTIONS pkg_postinst pkg_prerm

java-vm-2_pkg_postinst() {
	# Set the generation-2 system VM, if it isn't set
	if [[ -z "$(java-config-2 -f)" ]]; then
		java_set_default_vm_
	fi

	if [[ ${JAVA_VM_NO_GENERATION1} != "true" ]]; then
		local systemvm1="$(java-config-1 -f)"
		# no generation-1 system-vm was yet set
		if [[ -z "${systemvm1}" ]]; then
			einfo "No valid generation-1 system-vm set, setting to ${P}"
			java-config-1 --set-system-vm=${P}
		# dirty check to see if we are upgrading current generation-1 system vm
		elif [[ ${systemvm1} =~ "^${VMHANDLE}" ]]; then
		    einfo "Upgrading generation-1 system-vm... updating its env file"
		    java-config-1 --set-system-vm=${P}
		fi
		# else... some other VM is being updated, so we don't have to worry
	fi

	if has nsplugin ${IUSE} && use nsplugin; then
		if [[ ! -f /usr/lib/nsbrowser/plugins/javaplugin.so ]]; then
			eselect java-nsplugin set ${VMHANDLE}
		fi
	fi

	java_mozilla_clean_
}

java-vm-2_pkg_prerm() {
	if [[ "$(java-config -f)" == "${VMHANDLE}" ]]; then
		ewarn "It appears you are removing your default system VM!"
		ewarn "Please run java-config -L then java-config -S to set a new system VM!"
	fi
}

java_set_default_vm_() {
	java-config-2 --set-system-vm="${VMHANDLE}"

	einfo " After installing ${P} this"
	einfo " was set as the default JVM to run."
}

get_system_arch() {
	local sarch
	sarch=$(echo ${ARCH} | sed -e s/[i]*.86/i386/ -e s/x86_64/amd64/ -e s/sun4u/sparc/ -e s/sparc64/sparc/ -e s/arm.*/arm/ -e s/sa110/arm/)
	if [ -z "${sarch}" ]; then
		sarch=$(uname -m | sed -e s/[i]*.86/i386/ -e s/x86_64/amd64/ -e s/sun4u/sparc/ -e s/sparc64/sparc/ -e s/arm.*/arm/ -e s/sa110/arm/)
	fi
	echo ${sarch}
}

# TODO rename to something more evident, like install_env_file
set_java_env() {
	local platform="$(get_system_arch)"
	local env_file="${D}${JAVA_VM_CONFIG_DIR}/${VMHANDLE}"
	local old_env_file="${D}/etc/env.d/java/20${P}"
	local source_env_file="${FILESDIR}/${VMHANDLE}.env"

	if [[ ! -f ${source_env_file} ]]; then
		die "Unable to find the env file: ${source_env_file}"
	fi

	dodir ${JAVA_VM_CONFIG_DIR}
	dodir /etc/env.d/java # generation-1 compatibility
	sed \
		-e "s/@P@/${P}/g" \
		-e "s/@PN@/${PN}/g" \
		-e "s/@PV@/${PV}/g" \
		-e "s/@PF@/${PF}/g" \
		-e "s/@PLATFORM@/${platform}/g" \
		-e "/^LDPATH=.*lib\\/\\\"/s|\"\\(.*\\)\"|\"\\1${platform}/:\\1${platform}/server/\"|" \
		< ${source_env_file} \
		> ${env_file} || die "sed failed"

	echo "VMHANDLE=\"${VMHANDLE}\"" >> ${env_file}
	
	# generation-1 compatibility
	if [[ ${JAVA_VM_NO_GENERATION1} != true ]]; then
		# We need to strip some things out of the new style env,
		# because these end up going in the env
		sed -e 's/.*CLASSPATH.*//' \
			-e 's/.*PROVIDES.*//' \
			${env_file} \
			> ${old_env_file} || die "failed to create old-style env file"
	fi

	[[ -n ${JAVA_PROVIDE} ]] && echo "PROVIDES=\"${JAVA_PROVIDE}\"" >> ${env_file}

	local java_home=$(source ${env_file}; echo ${JAVA_HOME})
	[[ -z ${java_home} ]] && die "No JAVA_HOME defined in ${env_file}"

	# Make the symlink
	dosym ${java_home} ${JAVA_VM_DIR}/${VMHANDLE} \
		|| die "Failed to make VM symlink at ${JAVA_VM_DIR}/${VMHANDE}"
}


java_get_plugin_dir_() {
	echo /usr/$(get_libdir)/nsbrowser/plugins
}

install_mozilla_plugin() {
	local plugin=${1}

	if [ ! -f "${D}/${plugin}" ] ; then
		die "Cannot find mozilla plugin at ${D}/${plugin}"
	fi

	local plugin_dir=/usr/share/java-config-2/nsplugin
	dodir ${plugin_dir}
	dosym ${plugin} ${plugin_dir}/${VMHANDLE}-javaplugin.so
}

java_mozilla_clean_() {
	# Because previously some ebuilds installed symlinks outside of pkg_install
	# and are left behind, which forces you to manualy remove them to select the
	# jdk/jre you want to use for java
	local plugin_dir=$(java_get_plugin_dir_)
	for file in ${plugin_dir}/javaplugin_*; do
		rm -f ${file}
	done
	for file in ${plugin_dir}/libjavaplugin*; do
		rm -f ${file}
	done
}

