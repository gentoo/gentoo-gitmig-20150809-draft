# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox/busybox-1.00-r1.ebuild,v 1.14 2005/04/08 18:37:44 solar Exp $

inherit eutils

#SNAPSHOT=20040726

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="http://www.busybox.net/"
if [[ -n $SNAPSHOT ]] ; then
	MY_P=${PN}
	SRC_URI="http://www.busybox.net/downloads/snapshots/${PN}-${SNAPSHOT}.tar.bz2"
else
	MY_P=${PN}-${PV/_/-}
	SRC_URI="http://www.busybox.net/downloads/${MY_P}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~mips ppc sparc x86 ~ppc64"
IUSE="debug uclibc static savedconfig netboot floppyboot make-symlinks"

DEPEND="virtual/libc
	>=sys-apps/sed-4"
RDEPEND="!static? ( virtual/libc )"

S=${WORKDIR}/${MY_P}

# <pebenito> then eventually turning on selinux would mean
# adding a dep: selinux? ( sys-libs/libselinux )

busybox_config_option() {
	[ "$2" = "" ] && return 1
	case $1 in
		y) sed -i -e "s:.*CONFIG_$2.*set:CONFIG_$2=y:g" .config;;
		n) sed -i -e "s:CONFIG_$2=y:# CONFIG_$2 is not set:g" .config;;
		*) return 1;;
	esac
	einfo `grep CONFIG_$2 .config`
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# patches for 1.00 go here.
	epatch ${FILESDIR}/1.00/busybox-read-timeout.patch
	epatch ${FILESDIR}/1.00/readlink-follow.patch
	epatch ${FILESDIR}/1.00/more-insmod-arches.patch

	# Don't let KBUILD_OUTPUT mess us up #88088
	unset KBUILD_OUTPUT

	#bunzip
	#ftp://ftp.simtreas.ru/pub/my/bb/new/find.c.gz

	# check for a busybox config before making one of our own.
	# if one exist lets return and use it.
	# fine grained config control for user defined busybox configs.
	# [package]-[version]-[revision].config
	# [package]-[version].config
	# [package].config

	if use savedconfig ; then
		[ -r .config ] && rm .config
		for conf in ${PN}-${PV}-${PR} ${PN}-${PV} ${PN}; do
			configfile=/etc/${PN}/${CHOST}/${conf}.config
			if [ -r ${configfile} ]; then
				cp ${configfile} ${S}/.config
				break;
			fi
		done
		if [ -r "${S}/.config" ]; then
			einfo "Found your ${configfile} and using it."
			return 0
		fi
	fi
	if use netboot ; then
		cp ${FILESDIR}/config-netboot .config
		sed -i \
			-e '/DEFAULT_SCRIPT/s:/share/udhcpc/default.script:/lib/udhcpc.script:' \
			networking/udhcp/libbb_udhcp.h \
			|| die "fixing netboot/udhcpc"
	elif use floppyboot ; then
		cp ${FILESDIR}/config-floppyboot .config
	fi

	# busybox has changed quite a bit from 0.[5-6]* to 1.x so this
	# config might not be cd ready.

	make allyesconfig > /dev/null
	busybox_config_option n DMALLOC
	busybox_config_option n FEATURE_SUID

	# If these are not set and we are using a uclibc/busybox setup
	# all calls to system() will fail.
	busybox_config_option y FEATURE_SH_IS_ASH
	busybox_config_option n FEATURE_SH_IS_NONE

	use static \
		&& busybox_config_option y STATIC \
		|| busybox_config_option n STATIC

	# 1.00-pre2 uses the old selinux api which is no longer
	# maintained. perhaps the next stable release will include
	# support. 
	# 1.00-pre5  pebenito says busybox is still using the old se api.
	#use selinux \
	#	&& busybox_config_option y SELINUX \
	#	|| 
	busybox_config_option n SELINUX

	use debug \
		&& busybox_config_option y DEBUG \
		|| busybox_config_option n DEBUG

	#busybox_features=`grep CONFIG_ .config | tr '#' '\n' | 
	#	awk  '{print $1}' | cut -d = -f 1 | grep -v ^$ | cut -c 8- | 
	#		tr [A-Z] [a-z] | awk '{print "busybox_"$1}'`
	#for f in $busybox_features; do
	#	has $f ${FEATURES} && busybox_config_option y `echo ${f/busybox_/}|tr [a-z] [A-Z]`
	#done
	( echo | make clean oldconfig > /dev/null ) || :
}

busybox_set_cross_compiler() {
	type -p ${CHOST}-ar && export CROSS=${CHOST}-
}

src_compile() {
	busybox_set_cross_compiler
	#emake -j1 CROSS="${CROSS}" include/config.h busybox || die
	emake -j1 CROSS="${CROSS}" busybox || die
}

src_install() {
	busybox_set_cross_compiler

	into /
	dobin busybox
	if use make-symlinks ; then
		if [ ! "${VERY_BRAVE_OR_VERY_DUMB}" = "yes" ] && [ "${ROOT}" = "/" ];
		then
			ewarn "setting USE=make-symlinks and emerging to / is very dangerous."
			ewarn "it WILL overwrite lots of system programs like: ls bash awk grep (bug 60805 for full list)."
			ewarn "If you are creating a binary only and not merging this is probably ok."
			ewarn "set env VERY_BRAVE_OR_VERY_DUMB=yes if this is realy what you want."
			die "silly options will destroy your system"
		fi
		make CROSS="${CROSS}" install || die
		dodir /bin
		cp -a _install/bin/* ${D}/bin/
		dodir /sbin
		cp -a _install/sbin/* ${D}/sbin/
		cd ${D}
		local symlink
		for symlink in {bin,sbin}/* ; do
			[ -L "${symlink}" ] || continue
			[ -e "${ROOT}/${symlink}" ] \
				&& eerror "Deleting symlink ${symlink} because it exists in ${ROOT}" \
				&& rm ${symlink}
		done
		cd ${S}
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
		cd ${S}
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
		newins ${S}/.config ${PN}-${PV}-${PR}.config
	fi
}

pkg_postinst() {
	echo
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
	echo
}
