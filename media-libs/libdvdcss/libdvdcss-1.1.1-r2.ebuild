# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdcss/libdvdcss-1.1.1-r2.ebuild,v 1.10 2004/03/19 07:56:04 mr_bones_ Exp $

IUSE=""

S="${WORKDIR}/${P}"
DESCRIPTION="A portable abstraction library for DVD decryption"
SRC_URI="http://www.videolan.org/pub/videolan/libdvdcss/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.videolan.org/libdvdcss/"

SLOT="1.1"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc"

src_compile() {

	# Dont use custom optimiziations, as it gives problems
	# on some archs
	CFLAGS="" \
	CXXFLAGS="" \
	econf || die
	make || die
}

src_install() {

	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO

	##
	## 0.0.3.* and 1.0.0 compat
	##

	# NOTE: this should be the last code in src_install() !!!

	if [ -L ${D}/usr/lib/libdvdcss.so ]
	then
		# on some locales the name of the file a symlink points to, is in the
		# tenth field, and not the eleventh (bug #2908)
		LC_ALL='C'
		local realname=$(ls -l ${D}/usr/lib/libdvdcss.so |gawk '{print $11}')
		[ -z "${realname}" ] && \
			realname=$(ls -l ${D}/usr/lib/libdvdcss.so |gawk '{print $10}')
		[ -z "${realname}" ] && return 0

		for x in libdvdcss.so.0 libdvdcss.so.1
		do
			dosym ${realname} /usr/lib/${x}
		done
	fi
}

pkg_preinst() {

	# these could cause problems if they exist from
	# earlier builds
	for x in libdvdcss.so.0 libdvdcss.so.1
	do
		if [ -f /usr/lib/${x} ] || [ -L /usr/lib/${x} ]
		then
			rm -f /usr/lib/${x}
		fi
	done
}

