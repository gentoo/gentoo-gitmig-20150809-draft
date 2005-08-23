# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/divx4linux/divx4linux-20030428-r1.ebuild,v 1.9 2005/08/23 17:13:27 flameeyes Exp $

DXVER="505"
DESCRIPTION="Binary release of DivX Codec 5.0.5"
HOMEPAGE="http://www.divx.com/"
SRC_URI="http://download.divx.com/divx/${PN}-std-${PV}.tar.gz"

LICENSE="DIVX"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="nostrip"

DEPEND="virtual/libc
	sys-libs/lib-compat
	!media-tv/nvrec"

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
	cp -pPR 'DivX MPEG-4 Codec and Its Interface.htm' ${D}/usr/share/doc/${PF}/html
}
