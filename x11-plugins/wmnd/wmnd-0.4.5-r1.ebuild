# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnd/wmnd-0.4.5-r1.ebuild,v 1.1 2003/07/07 13:02:52 joker Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="WindowMaker Network Devices (dockapp)"
HOMEPAGE="http://www.yuv.info/wmnd/"
SRC_URI="http://www.yuv.info/wmnd/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/x11
	x11-wm/windowmaker"


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
