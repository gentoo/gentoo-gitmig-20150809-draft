# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/divx4linux/divx4linux-20030428.ebuild,v 1.1 2003/06/29 19:51:50 cretin Exp $

DXVER="505"
DESCRIPTION="Binary release of DivX Codec 5.0.5"
SRC_URI="http://download.divx.com/divx/${PN}-std-${PV}.tar.gz"
HOMEPAGE="http://www.divx.com/"

SLOT="0"
LICENSE="DIVX"
KEYWORDS="~x86 -ppc -sparc "

DEPEND="virtual/glibc"

DEBUG="yes"
RESTRICT="nostrip"

src_install() {
	for lib in *.so ; do
		dolib.so ${lib}
		dosym /usr/lib/${lib} /usr/lib/${lib}.0
	done

	# Fix bug #13776.
	# Not needed in divx4linux-20030428.ebuild, as pattern doesn't exist
	#dosed -e 's|c:\\trace_b.txt|/dev/null\x00\x00\x00\x00\x00|' \
	#	/usr/lib/libdivxencore.so

	insinto /usr/include
	doins *.h

#   These are no longer in divx4linux-20030428.ebuild
#	dodoc README.linux license.txt
	dodir /usr/share/doc/${PF}/html
	cp -a 'DivX MPEG-4 Codec and Its Interface.htm' ${D}/usr/share/doc/${PF}/html
}

