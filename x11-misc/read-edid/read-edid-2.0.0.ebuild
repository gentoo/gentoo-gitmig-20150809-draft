# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/read-edid/read-edid-2.0.0.ebuild,v 1.3 2008/12/15 04:09:24 yngwin Exp $

DESCRIPTION="Program that can get information from a PnP monitor"
HOMEPAGE="http://www.polypux.org/projects/read-edid/"
SRC_URI="http://www.polypux.org/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
DEPEND=">=dev-libs/libx86-1.1"
RDEPEND="$DEPEND"

src_compile() {
	econf --mandir=/usr/share/man || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
