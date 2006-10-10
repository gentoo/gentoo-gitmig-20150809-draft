# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/zoinks/zoinks-0.4.0.ebuild,v 1.5 2006/10/10 18:14:30 nixnut Exp $

inherit eutils

DESCRIPTION="programmer's text editor and development environment"
HOMEPAGE="http://zoinks.mikelockwood.com/"
SRC_URI="http://zoinks.mikelockwood.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls imlib"

DEPEND="nls? ( sys-devel/gettext )
	imlib? ( media-libs/imlib )
	|| ( (  x11-libs/libX11
		x11-libs/libXpm
		x11-libs/libXext
		x11-libs/libXt )
		virtual/x11 )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc-4.1-fix.diff
}

src_compile() {
	econf \
		`use_enable nls` \
		`use_enable imlib` \
		|| die
	emake  || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README INSTALL AUTHORS NEWS ChangeLog
}
