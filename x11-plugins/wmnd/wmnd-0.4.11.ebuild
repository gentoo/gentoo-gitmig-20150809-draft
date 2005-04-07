# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnd/wmnd-0.4.11.ebuild,v 1.4 2005/04/07 17:12:34 blubb Exp $

IUSE=""
DESCRIPTION="WindowMaker Network Devices (dockapp)"
HOMEPAGE="http://www.yuv.info/wmnd/"
SRC_URI="ftp://ftp.yuv.info/pub/wmnd/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc amd64"

DEPEND="virtual/x11"

src_compile() {
	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install() {
	einstall || die "make install failed"

	dodoc README AUTHORS COPYING ChangeLog INSTALL NEWS TODO

	# gpl.info is no valid .info file. Causes errors with install-info.
	rm -r ${D}/usr/share/info
}
