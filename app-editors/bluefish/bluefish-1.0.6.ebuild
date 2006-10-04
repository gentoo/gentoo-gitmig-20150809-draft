# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-1.0.6.ebuild,v 1.1 2006/10/04 03:52:54 hanno Exp $

inherit eutils fdo-mime

IUSE="nls spell gnome"

DESCRIPTION="A GTK HTML editor for the experienced web designer or programmer."
SRC_URI="http://www.bennewitz.com/bluefish/stable/source/${P}.tar.bz2"
HOMEPAGE="http://bluefish.openoffice.nl/"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"

RDEPEND=">=x11-libs/gtk+-2
	dev-libs/libpcre
	spell? ( app-text/aspell )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	gnome? ( gnome-base/libgnomeui )"

src_compile() {
	econf --disable-update-databases \
		`use_enable nls` \
		`use_with gnome libgnomeui` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	update-mime-database /usr/share/mime
}
