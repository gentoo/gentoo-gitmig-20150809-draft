# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox/busybox-1.00_pre4.ebuild,v 1.1 2003/12/19 00:00:24 solar Exp $

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Utilities for rescue and embedded systems"
SRC_URI="http://www.busybox.net/downloads/${MY_P}.tar.gz"
HOMEPAGE="http://www.busybox.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="debug static uclibc"

# Forward anticipation of expected supported arches would include ~x86
# ~alpha ~mips ~ppc ~sparc

DEPEND="virtual/glibc
	uclibc? ( dev-libs/uclibc )
"
RDEPEND="!static? ${DEPEND}"
# <pebenito> then eventually turning on selinux would mean
# adding a dep: selinux? ( sys-libs/libselinux )

busybox_config_option() {
	[ "$2" = "" ] && return 1
	case $1 in
		y) sed -e "s:.*CONFIG_$2.*set:CONFIG_$2=y:g" < \
			.config > .config~;;
		n) sed -e "s:CONFIG_$2=y:# CONFIG_$2 is not set:g" < \
			.config > .config~;;
		*) return 1;;
	esac
	mv .config{~,}
	einfo `grep CONFIG_$2 .config`
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# busybox has changed quite a bit from 0.[5-6]* to 1.x so this
	# config might not be cd ready.
	make defconfig

	#[ -f .config ] || die "No .config file found for ${PN}"

	# setting the cross compiler from here would be somewhat of a
	# pain do to as we would need a multiline sed expression which
	# does not always seem to work so hot for me.

	[ `use static` ] && busybox_config_option y STATIC ||
		busybox_config_option n STATIC

	# 1.00-pre2 uses the old selinux api which is no longer
	# maintained. perhaps the next stable release will include
	# support. 
	# 

	#[ `use selinux` ] && busybox_config_option y SELINUX ||
	#	busybox_config_option n SELINUX

	[ `use debug` ] && busybox_config_option y DEBUG ||
		busybox_config_option n DEBUG

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

	# This could almost work but might not be a good idea till we
	# find a better sed expression for busybox_config_option() or
	# per package use flags come into play.
	#
	#busybox_features=`grep CONFIG_ .config | tr '#' '\n' | 
	#	awk  '{print $1}' | cut -d = -f 1 | grep -v ^$ | cut -c 8- | 
	#		tr [A-Z] [a-z] | awk '{print "busybox_"$1}'`
	#for f in $busybox_features; do
	#	has $f ${FEATURES} && busybox_config_option y `echo ${f/busybox_/}|tr [a-z] [A-Z]`
	#done
}

src_compile() {
	if [ `use uclibc` ]; then
		case ${ARCH} in
			x86*) CROSS="/usr/i386-linux-uclibc/bin/i386-uclibc-";;
			*) ;;
		esac
	fi
	[ -n "${CROSS}" ] && einfo "Setting cross compiler prefix to ${CROSS}"
	# MAKEOPTS="-j1" emake CROSS="${CROSS}" include/config.h busybox || die
	MAKEOPTS="-j1" emake CROSS="${CROSS}" busybox || die
}

src_install() {
	into /
	dobin busybox

	into /usr
	dodoc AUTHORS Changelog LICENSE README TODO

	cd docs || die
	docinto txt
	dodoc *.txt
	docinto pod
	dodoc *.pod
	dohtml *.html
	dohtml *.sgml

	# no man files?
	# cd ../man && doman *.1

	cd ../examples || die
	docinto examples
	dodoc inittab
	dodoc depmod.pl

	cd bootfloppy || die
	docinto bootfloppy
	for f in bootfloppy.txt display.txt mkdevs.sh etc/* etc/init.d/* ; do
		[ -f ${f} ] && dodoc ${f}
	done

	cd ../../ || die

	if [ `has buildpkg ${FEATURES}` -a `has keepwork ${FEATURES}` ]; then
		cd ${S}
		# this should install to the ./_install/ dir by default.
		# we make a micro pkg of busybox that can be used for
		# embedded systems -solar
		make install && cd ./_install/ &&
			tar --no-same-owner -jcvf \
				${WORKDIR}/${MY_P}-${ARCH}.bz2 . && cd ..
	fi
}

pkg_postinst() {
	einfo ""
	einfo "Edit /usr/portage/sys-apps/busybox/files/${MY_P}.config and"
	einfo "re-emerge if you need to add/remove functionality in "
	einfo "BusyBox."
	einfo ""
	[ `has buildpkg ${FEATURES}` -a `has keepwork ${FEATURES}` ] &&
		einfo "A ${PN} minipkg can be found at ${WORKDIR}/${MY_P}-${ARCH}.bz2"
}
