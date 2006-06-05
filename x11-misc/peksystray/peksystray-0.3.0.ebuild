# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/peksystray/peksystray-0.3.0.ebuild,v 1.1 2006/06/05 17:51:53 nelchael Exp $

DESCRIPTION="A system tray dockapp for window managers supporting docking"
HOMEPAGE="http://sourceforge.net/projects/peksystray/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libXt
		x11-libs/libX11 )
	virtual/x11 )"
DEPEND="${RDEPEND}"

src_compile() {
	econf --x-libraries=/usr/lib || die "econf failed"
	emake || die "emake failed"
}

src_install() {

	dobin src/peksystray
	dodoc AUTHORS NEWS README THANKS TODO

}
