# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-qt-engine/gtk-qt-engine-0.6-r1.ebuild,v 1.1 2005/01/15 13:34:23 motaboy Exp $

inherit gtk-engines2 eutils kde-functions

DESCRIPTION="GTK+2 Qt Theme Engine"
HOMEPAGE="http://www.freedesktop.org/Software/gtk-qt"
SRC_URI="http://www.freedesktop.org/~davidsansome/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE="arts debug"
SLOT="2"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2.2.0
	arts? ( kde-base/arts )"

need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-kcm-fixinstallationdir.patch
}

src_compile() {
	make -f ${S}/admin/Makefile.common

	local myconf="$(use_with arts) $(use_enable debug)"
	econf ${myconf} || die
	emake || die
}
