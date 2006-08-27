# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gmanedit/gmanedit-0.3.3-r4.ebuild,v 1.2 2006/08/27 16:24:35 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Gnome based manpage editor"
SRC_URI="http://gmanedit.sourceforge.net/files/${P}.tar.bz2"
HOMEPAGE="http://gmanedit.sourceforge.net/"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=gnome-base/gnome-libs-1.4.1.4
	|| (
	( >=x11-libs/libX11-1.0.0
	>=x11-libs/libICE-1.0.0
	>=x11-libs/libXext-1.0.0
	>=x11-libs/libSM-1.0.0
	>=x11-libs/gtk+-1.2.10-r11
	>=x11-libs/libXi-1.0.0 )
	virtual/x11 )"

S=${WORKDIR}/${P}.orig

src_compile() {
	epatch "${FILESDIR}"/${P}-xterm.patch
	econf --disable-nls || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog TODO README NEWS
}
