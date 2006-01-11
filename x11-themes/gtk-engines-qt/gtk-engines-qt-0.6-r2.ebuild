# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qt/gtk-engines-qt-0.6-r2.ebuild,v 1.2 2006/01/11 20:01:03 gustavoz Exp $

inherit eutils kde-functions

MY_P="gtk-qt-engine-${PV}"
DESCRIPTION="GTK+2 Qt Theme Engine"
HOMEPAGE="http://www.freedesktop.org/Software/gtk-qt"
SRC_URI="http://www.freedesktop.org/~davidsansome/${MY_P}.tar.bz2"
LICENSE="GPL-2"

IUSE="arts debug"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2.2
	arts? ( kde-base/arts )"

need-kde 3
# Set slot after the need-kde. Fixes bug #78455.
SLOT="2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${MY_P}-kcm-fixinstallationdir.patch
	epatch ${FILESDIR}/gtk-2.8-fix.patch
}

src_compile() {
	make -f ${S}/admin/Makefile.common

	local myconf="$(use_with arts) $(use_enable debug)"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS
}
