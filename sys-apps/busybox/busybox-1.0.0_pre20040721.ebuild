# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox/busybox-1.0.0_pre20040721.ebuild,v 1.1 2004/07/21 13:13:49 solar Exp $

inherit eutils

DESCRIPTION="Utilities for rescue and embedded systems"
SNAPSHOT=20040721
HOMEPAGE="http://www.busybox.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~mips ~arm ~amd64"
IUSE="debug static savedconfig make-busybox-symlinks"
#IUSE="${IUSE} cross"

MY_PV=${PV/_/-}

if [ "$SNAPSHOT" != "" ]; then
	MY_P=${PN}
	SRC_URI="http://www.busybox.net/downloads/snapshots/${PN}-${SNAPSHOT}.tar.bz2"
else
	MY_P=${PN}-${MY_PV}
	SRC_URI="http://www.busybox.net/downloads/${MY_P}.tar.gz"
fi

S=${WORKDIR}/${MY_P}

DEPEND="virtual/libc
	!amd64? ( uclibc? ( dev-libs/uclibc ) )
	>=sys-apps/sed-4"

RDEPEND="!static? ( ${DEPEND} )"

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

	use amd64 && epatch ${FILESDIR}/${P}-amd64.patch

	# check for a busybox config before making one of our own.
	# if one exist lets return and use it.
	# fine grained config control for user defined busybox configs.
	# [package]-[version]-[revision].config
	# [package]-[version].config
	# [package].config

	if use savedconfig ; then
		[ -r .config ] && rm .config
		for conf in {${PN}-${PV}-${PR},${PN}-${PV},${PN}}.config; do
			if [ -r /etc/${PN}/${CCHOST}/${conf} ]; then
				cp /etc/${PN}/${CCHOST}/${conf} ${S}/.config
				break;
			fi
		done
		if [ -r "${S}/.config" ]; then
			einfo "Found your /etc/${PN}/${CCHOST}/${conf} and using it."
			return 0
		fi
	fi

	# busybox has changed quite a bit from 0.[5-6]* to 1.x so this
	# config might not be cd ready.

	make allyesconfig > /dev/null
	busybox_config_option n DMALLOC
	busybox_config_option n FEATURE_SUID

	# setting the cross compiler from here would be somewhat of a
	# pain do to as we would need a multiline sed expression which
	# does not always seem to work so hot for me.

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

	# Supported architectures:

	# Busybox in general will build on any architecture supported by
	# gcc.  It has a few specialized features added for __sparc__
	# and __alpha__.  insmod functionality is currently limited to
	# x86, ARM, SH3/4, powerpc, m68k, MIPS, and v850e.
	case ${ARCH} in
		alpha|sparc*)
			# non x86 needs to figure out what works for
			# them the best. sparc64 bobmed while building
			# ash in my tests
			busybox_config_option n INSMOD
			busybox_config_option n MODPROBE
			busybox_config_option n RMMOD;;
		*) ;;
	esac

	#busybox_features=`grep CONFIG_ .config | tr '#' '\n' | 
	#	awk  '{print $1}' | cut -d = -f 1 | grep -v ^$ | cut -c 8- | 
	#		tr [A-Z] [a-z] | awk '{print "busybox_"$1}'`
	#for f in $busybox_features; do
	#	has $f ${FEATURES} && busybox_config_option y `echo ${f/busybox_/}|tr [a-z] [A-Z]`
	#done
	( echo | make clean oldconfig > /dev/null ) || :
}

busybox_set_cross_compiler() {
	return 0
	# revisit this another day.
	#if use cross ; then
	#	case ${ARCH} in
	#		x86*) CROSS="/usr/i386-linux-uclibc/bin/i386-uclibc-";;
	#		*) ;;
	#	esac
	#fi
	[ -n "${CROSS}" ] && einfo "Setting cross compiler prefix to ${CROSS}"
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
	if use make-busybox-symlinks ; then
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

	dodoc AUTHORS Changelog LICENSE README TODO

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
	if [ `has buildpkg ${FEATURES}` -a `has keepwork ${FEATURES}` ]; then
		cd ${S}
		# this should install to the ./_install/ dir by default.
		# we make a micro pkg of busybox that can be used for
		# embedded systems -solar
		if ! use make-busybox-symlinks ; then
			make CROSS="${CROSS}" install || die
		fi
		cd ./_install/ \
			&& tar --no-same-owner -jcvf ${WORKDIR}/${MY_P}-${ARCH}.bz2 . \
			&& cd ..
	fi

	if use savedconfig ; then
		einfo "Saving this build config to /etc/${PN}/${CCHOST}/${PN}-${PV}-${PR}.config"
		einfo "Read this ebuild for more info on how to take advantage of this option"
		insinto /etc/${PN}/${CCHOST}/
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
