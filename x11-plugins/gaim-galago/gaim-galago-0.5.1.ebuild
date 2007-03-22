# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-galago/gaim-galago-0.5.1.ebuild,v 1.2 2007/03/22 17:44:35 compnerd Exp $

inherit eutils

DESCRIPTION="Galago feed plugin for Gaim."
HOMEPAGE="http://www.galago-project.org"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-im/gaim
		 >=dev-libs/glib-2.8
		 >=dev-libs/libgalago-0.5.2"
DEPEND="${RDEPEND}
		>=sys-devel/gettext-0.10.40
		>=dev-util/pkgconfig-0.9"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS
}
