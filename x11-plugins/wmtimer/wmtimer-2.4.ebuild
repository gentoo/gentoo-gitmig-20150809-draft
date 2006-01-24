# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtimer/wmtimer-2.4.ebuild,v 1.19 2006/01/24 23:30:04 nelchael Exp $

IUSE=""

S=${WORKDIR}/${P}/${PN}

DESCRIPTION="Dockable clock which can run in alarm, countdown timer or chronograph mode"
SRC_URI="http://www.darkops.net/wmtimer/${P}.tar.gz"
HOMEPAGE="http://www.darkops.net/wmtimer/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc64 ppc ~sparc"

RDEPEND="=x11-libs/gtk+-1.2*"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-O2 -Wall:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_install () {
	dobin wmtimer
	cd ..
	dodoc README CREDITS Changelog
}
