# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-0.13.ebuild,v 1.1 2004/12/07 15:44:18 hanno Exp $

inherit eutils

IUSE="nls spell"

DESCRIPTION="A GTK HTML editor for the experienced web designer or programmer."
SRC_URI="http://pkedu.fbt.eitn.wau.nl/~olivier/downloads/${P}.tar.bz2"
HOMEPAGE="http://bluefish.openoffice.nl/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha ~ia64 ~ppc64"
SLOT="0"

RDEPEND=">=x11-libs/gtk+-2
	dev-libs/libpcre
	spell? ( app-text/aspell )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_compile() {
	epatch ${FILESDIR}/bluefish-make-destdir.patch

	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die
}
