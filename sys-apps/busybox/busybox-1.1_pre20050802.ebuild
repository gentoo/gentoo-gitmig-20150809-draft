# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox/busybox-1.1_pre20050802.ebuild,v 1.3 2005/08/24 00:29:50 vapier Exp $

inherit eutils

SNAPSHOT=${PV/*_pre}

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="http://www.busybox.net/"
if [[ -n ${SNAPSHOT} ]] ; then
	MY_P=${PN}
	SRC_URI="http://www.busybox.net/downloads/snapshots/${PN}-${SNAPSHOT}.tar.bz2"
else
	MY_P=${PN}-${PV/_/-}
	SRC_URI="http://www.busybox.net/downloads/${MY_P}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE="debug static savedconfig netboot floppyboot make-symlinks"

DEPEND=""

S=${WORKDIR}/${MY_P}

# <pebenito> then eventually turning on selinux would mean
# adding a dep: selinux? ( sys-libs/libselinux )

busybox_set_env() {
	type -p ${CHOST}-ar && export CROSS=${CHOST}-
	# Don't let KBUILD_OUTPUT mess us up #88088
	unset KBUILD_OUTPUT
}

busybox_config_option() {
	case $1 in
		y) sed -i -e "s:.*CONFIG_$2.*set:CONFIG_$2=y:g" .config;;
		n) sed -i -e "s:CONFIG_$2=y:# CONFIG_$2 is not set:g" .config;;
		Y) echo "CONFIG_$2=y" >> .config;;
		N) echo "CONFIG_$2=n" >> .config;;
		*) use $1 \
		       && busybox_config_option y $2 \
		       || busybox_config_option n $2
		   return 0
		   ;;
	esac
	einfo $(grep "CONFIG_$2[= ]" .config)
}

src_unpack() {
	busybox_set_env
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/1.00/bb.patch

	# check for a busybox config before making one of our own.
	# if one exist lets return and use it.
	# fine grained config control for user defined busybox configs.
	# [package]-[version]-[revision].config
	# [package]-[version].config
	# [package].config

	if use savedconfig ; then
		[[ -r .config ]] && rm .config
		for conf in ${PN}-${PV}-${PR} ${PN}-${PV} ${PN}; do
			configfile=${ROOT}/etc/${PN}/${CHOST}/${conf}.config
			[[ -r ${configfile} ]] || configfile=/etc/${PN}/${CHOST}/${conf}.config
			if [[ -r ${configfile} ]] ; then
				cp ${configfile} ${S}/.config
				break
			fi
		done
		if [[ -r ${S}/.config ]] ; then
			einfo "Found your ${configfile} and using it."
			return 0
		fi
	fi
	if use netboot ; then
		cp "${FILESDIR}"/config-netboot .config
		sed -i \
			-e '/DEFAULT_SCRIPT/s:/share/udhcpc/default.script:/lib/udhcpc.script:' \
			networking/udhcp/libbb_udhcp.h \
			|| die "fixing netboot/udhcpc"
	elif use floppyboot ; then
		cp "${FILESDIR}"/config-floppyboot .config
	fi

	# setup the config file
	make allyesconfig > /dev/null
	busybox_config_option n DMALLOC
	busybox_config_option n FEATURE_SUID_CONFIG

	# If these are not set and we are using a uclibc/busybox setup
	# all calls to system() will fail.
	busybox_config_option y FEATURE_SH_IS_ASH
	busybox_config_option n FEATURE_SH_IS_NONE

	busybox_config_option static STATIC
	busybox_config_option debug DEBUG
	use debug \
		&& busybox_config_option Y NO_DEBUG_LIB \
		&& busybox_config_option N DMALLOC \
		&& busybox_config_option N EFENCE

	# 1.00-pre5 uses the old selinux api which is no longer maintained
	#busybox_config_option selinux SELINUX
	busybox_config_option n SELINUX

	# default a bunch of uncommon options to off
	for opt in LOCALE_SUPPORT TFTP FTP{GET,PUT} IPCALC TFTP HUSH \
		LASH MSH INETD DPKG RPM2CPIO RPM FOLD LOGNAME OD CRONTAB \
		UUDECODE UUENCODE SULOGIN DC
	do
		busybox_config_option n ${opt}
	done

	make oldconfig > /dev/null
}

src_compile() {
	busybox_set_env
	emake -j1 CROSS="${CROSS}" depend || die "depend failed"
	emake CROSS="${CROSS}" busybox || die "build failed"
	if ! use static ; then
		mv busybox{,.bak}
		local failed=0
		emake -j1 \
			LDFLAGS="${LDFLAGS} -static" \
			CROSS="${CROSS}" \
			busybox || failed=1
		if [[ ${failed} == 1 ]] ; then
			if has_version '<sys-libs/glibc-2.3.5' ; then
				eerror "Your glibc has broken static support, ignorning static build failure."
				eerror "See http://bugs.gentoo.org/show_bug.cgi?id=94879"
				cp busybox.bak bb
			else
				die "static build failed"
			fi
		else
			mv busybox bb
		fi
		mv busybox{.bak,}
	fi
}

src_install() {
	busybox_set_env

	into /
	dobin busybox
	use static \
		&& dosym busybox /bin/bb \
		|| dobin bb

	if use make-symlinks ; then
		if [[ ! ${VERY_BRAVE_OR_VERY_DUMB} == "yes" ]] && [[ ${ROOT} == "/" ]] ; then
			ewarn "setting USE=make-symlinks and emerging to / is very dangerous."
			ewarn "it WILL overwrite lots of system programs like: ls bash awk grep (bug 60805 for full list)."
			ewarn "If you are creating a binary only and not merging this is probably ok."
			ewarn "set env VERY_BRAVE_OR_VERY_DUMB=yes if this is realy what you want."
			die "silly options will destroy your system"
		fi
		make CROSS="${CROSS}" install || die
		dodir /bin
		cp -pPR _install/bin/* "${D}"/bin/
		dodir /sbin
		cp -pPR _install/sbin/* "${D}"/sbin/
		cd "${D}"
		local symlink
		for symlink in {bin,sbin}/* ; do
			[[ -L ${symlink} ]] || continue
			[[ -e ${ROOT}/${symlink} ]] \
				&& eerror "Deleting symlink ${symlink} because it exists in ${ROOT}" \
				&& rm ${symlink}
		done
		cd "${S}"
	fi

	dodoc AUTHORS Changelog README TODO

	cd docs || die
	docinto txt
	dodoc *.txt
	docinto pod
	dodoc *.pod
	dohtml *.html *.sgml

	# no man files?
	# cd ../man && doman *.1

	cd ../examples || die
	docinto examples
	dodoc inittab depmod.pl

	cd bootfloppy || die
	docinto bootfloppy
	dodoc bootfloppy.txt display.txt mkdevs.sh etc/* etc/init.d/* 2>/dev/null

	cd ../../ || die
	if has buildpkg ${FEATURES} && has keepwork ${FEATURES} ; then
		cd "${S}"
		# this should install to the ./_install/ dir by default.
		# we make a micro pkg of busybox that can be used for
		# embedded systems -solar
		if ! use make-symlinks ; then
			make CROSS="${CROSS}" install || die
		fi
		cd ./_install/ \
			&& tar --no-same-owner -jcvf ${WORKDIR}/${MY_P}-${ARCH}.bz2 . \
			&& cd ..
	fi

	if use savedconfig ; then
		einfo "Saving this build config to /etc/${PN}/${CHOST}/${PN}-${PV}-${PR}.config"
		einfo "Read this ebuild for more info on how to take advantage of this option"
		insinto /etc/${PN}/${CHOST}/
		newins "${S}"/.config ${PN}-${PV}-${PR}.config
	fi
}

pkg_postinst() {
	echo
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
	echo
}
