# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-qt-engine/gtk-qt-engine-0.5.ebuild,v 1.7 2005/01/05 06:25:53 cryos Exp $

inherit gtk-engines2 eutils kde-functions

need-kde 3

DESCRIPTION="GTK+2 Qt Theme Engine"
HOMEPAGE="http://xserver.freedesktop.org/Software/gtk-qt"
SRC_URI="http://xserver.freedesktop.org/Software/gtk-qt/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE="arts debug"
SLOT="2"
KEYWORDS="~x86 ~ppc"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2.2.0
	arts? ( kde-base/arts )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/scrollbars.patch
}

src_compile() {
	local myconf="$(use_with arts) $(use_enable debug)"
	econf ${myconf} || die
	emake || die
}
