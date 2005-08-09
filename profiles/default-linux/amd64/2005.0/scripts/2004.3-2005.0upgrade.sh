#!/bin/bash
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/profiles/default-linux/amd64/2005.0/scripts/2004.3-2005.0upgrade.sh,v 1.7 2005/08/09 01:47:26 eradicator Exp $

TMPDIR="$(portageq envvar PORTAGE_TMPDIR)"
PORTDIR="$(portageq envvar PORTDIR)"

# change to yes if you want to use DISTCC
if portageq envvar FEATURES | grep -q distcc ; then
	export USE_DISTCC="yes"
else
	export USE_DISTCC="no"
fi

#--- You shouldn't need to chane anything past this line ---

PORTAGE_REQ=">=sys-apps/portage-2.0.51-r9"
GCC_CONFIG_REQ=">=sys-devel/gcc-config-1.3.9"
DISTCC_REQ=">=sys-devel/distcc-2.18.3-r1"
EMUL_GLIBC_REQ=">=app-emulation/emul-linux-x86-glibc-2.3.4.20041102"
LINUX_HEADERS_REQ=">=sys-kernel/linux-headers-2.6.8.1-r3"

# When do we need to emerge sandbox instead of portage?
PORTAGE_NEEDSANDBOX=">sys-apps/portage-2.0.51.19"
SANDBOX_REQ="sys-apps/sandbox"

TMPDIR="${TMPDIR}/2005.0_upgrade"

if ! source /sbin/functions.sh ; then
	echo "$0: Failed to source /sbin/functions.sh" >&2
	exit 1
fi

mkdir -p ${TMPDIR} &> /dev/null
cd ${TMPDIR}

myDie() {
	if [[ -f step5 ]] ; then
		eerror "Upgrade failed in stage 6.  We were unable to unmerge the"
		eerror "emul-linux-x86-glibc package.  This is the last step of the upgrade process."
	elif [[ -f step4 ]] ; then
		eerror "Upgrade failed in stage 5.  This is the biggest step of the upgrade"
		eerror "process.  We were unable to build glibc for your system."
		eerror "Try running:"
		eerror "FEATURES=-sandbox emerge --oneshot sys-libs/glibc && touch ${TMPDIR}/step5"
	elif [[ -f step3 ]] ; then
		eerror "Upgrade failed in stage 4.  The upgrade script failed to change"
		eerror "your /etc/make.profile symlink to the 2005.0 profile.  Did"
		eerror "you intend to set PORTDIR to something other than ${PORTDIR}"
		eerror "in the upgrade script?  If so, set it and re-execute the script."
	elif [[ -f step2 ]] ; then
		eerror "Upgrade failed in stage 3.  Your multilib configuration is"
		eerror "probably broken, but 64bit applications will work fine while"
		eerror "you debug the problem.  If you wish to revert to a working"
		eerror "2004.3 multilib system, then delete /lib32 and /usr/lib32"
		eerror "and re-emerge your emul-* packages.  This process might also"
		eerror "fix whatever problem prevented the upgrade."
	elif [[ -f step1 ]] ; then
		eerror "Upgrade failed in stage 2.  You still have a fully functional"
		eerror "2004.3 system."
	elif [[ -f step0 ]] ; then
		eerror "Upgrade failed in stage 1.  You still have a fully functional"
		eerror "2004.3 system."
	else
		eerror "Upgrade failed updating portage.  No changes have been made to"
		eerror "your system by the upgrade process."
	fi

	echo
	ewarn "You may safely re-execute this upgrade script after correcting any"
	ewarn "any problems to resume the upgrade process."
	echo
	eerror "Please report the following error and any errors above if you file"
	eerror "a bug at http://bugs.gentoo.org"

	echo "${@}"
	exit 1
}

if [[ ! -f step0 ]]; then
	if [[ ( -d /lib32 && ! -L /lib32 ) || ( -d /usr/lib32 && ! -L /usr/lib32 ) ]] ; then
		eerror "It looks like you have /lib32 or /usr/lib32 directories already."
		eerror "Have you already begun a manual upgrade?  If so, pleasse revert your"
		eerror "changes and restart the script."
		exit 1
	fi

	if [[ -x /usr/bin/readlink ]] && /usr/bin/readlink /etc/make.profile | grep -q 2005 ; then
		eerror "Your /etc/make.profile symlink is not set to the 2004.3 profile.  This script"
		eerror "expects a 2004.3 environment to start the upgrade.  If you have started manually"
		eerror "upgrading your system, please revert the changes and start the script again."
		exit 1
	fi

	if [[ "$(gcc -m32 -print-multi-directory)" != "32" ]]; then
		eerror "Your compiler does not have multilib support. Pleasse switch to a multilib"
		eerror "enabled compiler with gcc-config.  If you don't have one on your system, you can"
		eerror "emerga a multilib gcc by executing the following line:"
		eerror "FEATURES=-sandbox USE=multilib emerge gcc"
		exit 1
	fi

	if [[ -f /proc/config.gz ]] ; then
		KERNEL_CONFIG="gunzip -dc /proc/config.gz"
	elif [[ -f /proc/config.bz2 ]] ; then
		KERNEL_CONFIG="bunzip2 -dc /proc/config.bz2"
	elif [[ -f /proc/config ]] ; then
		KERNEL_CONFIG="cat /proc/config"
	elif [[ -f /lib/modules/$(uname -r)/build/.config ]] ; then
		KERNEL_CONFIG="cat /lib/modules/$(uname -r)/build/.config"
	elif [[ -f /lib/modules/$(uname -r)/source/.config ]] ; then
		KERNEL_CONFIG="cat /lib/modules/$(uname -r)/source/.config"
	else
		ewarn "Can't find a config for the running kernel, so we're assuminig"
		ewarn "you correctly have CONFIG_IA32_EMULATION (support for 32bit"
		ewarn "applications) enabled."
		KERNEL_CONFIG="echo CONFIG_IA32_EMULATION=y"
	fi

	if ! eval ${KERNEL_CONFIG} | grep -q CONFIG_IA32_EMULATION=y ; then
		myDie "Running kernel does not have support for executing 32bit applications.  You need to enable CONFIG_IA32_EMULATION in your running kernel."
	fi

	# Always install portage since current might not be multilib friendly
	USE=multilib FEATURES=-sandbox emerge -v --oneshot ${PORTAGE_REQ} || \
		myDie "emerge portage failed"

	if portageq has_version / ${PORTAGE_NEEDSANDBOX} ; then \
		USE=multilib FEATURES=-sandbox emerge -v --oneshot ${SANDBOX_REQ} || \
		myDie "emerge sandbox failed"
	fi

	touch step0
fi

if [[ ! -f step1 ]]; then
	if ! portageq has_version / ${GCC_CONFIG_REQ} ; then \
		emerge -v --oneshot ${GCC_CONFIG_REQ} || \
		myDie "emerge gcc-config failed"
	fi

	if ! portageq has_version / ${EMUL_GLIBC_REQ} ; then \
		emerge -v --oneshot ${EMUL_GLIBC_REQ} || \
		myDie "emerge emul-glibc failed"
	fi

	if [[ "${USE_DISTCC}" == "yes" ]]; then
		if ! portageq has_version / ${DISTCC_REQ} ; then \
			emerge -v --oneshot ${DISTCC_REQ} || \
			myDie "emerge distcc failed"
		fi
	fi

	touch step1
fi

if [[ ! -f step2 ]]; then
	portageq has_version / linux26-headers && emerge unmerge linux26-headers
	if ! portageq has_version / ${LINUX_HEADERS_REQ} ; then \
			emerge -v --oneshot ${LINUX_HEADERS_REQ} || \
			myDie "emerge linux headers failed"
	fi
	
	if ! [[ -f /etc/env.d/04multilib ]]; then
		emerge -v --oneshot baselayout || myDie "emerge baselayout failed"
	fi
	
	if ! [[ -f /etc/env.d/04multilib ]]; then
		myDie "baselayout did not create /etc/env.d/04multilib as expected."
	fi
	
	env-update || myDie "env-update failed"

	echo "int main(){return 0;}" > ${TMPDIR}/32test.c
	if ! gcc -m32 ${TMPDIR}/32test.c -o ${TMPDIR}/32test >& ${TMPDIR}/32test.comp.log ; then
		myDie "Error compiling 32bit executable.  Please see ${TMPDIR}/32test.comp.log"
	fi

	if ! ${TMPDIR}/32test >& ${TMPDIR}/32test.exec.log ; then
		myDie "Error executing 32bit executable.  Please see ${TMPDIR}/32test.exec.log"
	fi

	touch step2
fi

if [[ ! -f step3 ]]; then
	[[ -L /lib32 ]] && rm /lib32 && mkdir /lib32
	[[ -L /usr/lib32 ]] && rm /usr/lib32 && mkdir /usr/lib32
	[[ -L /usr/X11R6/lib32 ]] && rm /usr/X11R6/lib32 && mkdir /usr/X11R6/lib32
	cp /emul/linux/x86/{usr/,}lib32/libsandbox.so* /usr/lib32 &> /dev/null
	[[ -f /usr/lib32/libsandbox.so ]] || myDie "Failed to copy over 32bit libsandbox."
	cp /emul/linux/x86/usr/lib32/libc.so /usr/lib32 || myDie "Failed to copy 32bit libc"
	cp /emul/linux/x86/usr/lib32/libpthread.so /usr/lib32 || myDie "Failed to copy 32bit libpthread."
	cp /emul/linux/x86/usr/lib32/*crt*.o /usr/lib32 || myDie "Failed to copy 32bit *crt*.o"
	[[ -d /emul/linux/x86/usr/lib32/nptl ]] && mkdir /usr/lib32/nptl
	[[ -d /emul/linux/x86/usr/lib32/nptl ]] && cp /emul/linux/x86/usr/lib32/nptl/libc.so /usr/lib32/nptl
	[[ -d /emul/linux/x86/usr/lib32/nptl ]] && cp /emul/linux/x86/usr/lib32/nptl/libpthread.so /usr/lib32/nptl
	env-update || myDie "env-update failed"

	touch step3
fi

if [[ ! -f step4 ]]; then
	if [[ -L /etc/make.profile ]] ; then
		rm /etc/make.profile || myDie "rm of old profile failed"
	fi

	ln -s ${PORTDIR}/profiles/default-linux/amd64/2005.0 /etc/make.profile || \
		myDie "link of new profile failed"
	touch step4
fi

if [[ ! -f step5 ]]; then
	emerge -v --oneshot "=$(portageq match / sys-libs/glibc)" || myDie "emerge glibc failed"
	touch step5
fi

if [[ ! -f step6 ]] ; then
	rm -f /emul/linux/x86/usr/lib/libsandbox.* &> /dev/null
	emerge unmerge emul-linux-x86-glibc || myDie "emerge emul-glibc failed"
	touch step6
fi

echo "-------------------------------------------------------------------"
echo "Congratulations, you're almost finished updating to 2005.0.  Please"
echo "run 'emerge -upv system' followed by 'emerge -uv system' to finish."

rm -rf ${TMPDIR}
