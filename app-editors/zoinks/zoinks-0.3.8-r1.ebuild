# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/zoinks/zoinks-0.3.8-r1.ebuild,v 1.4 2007/07/22 09:01:03 calchan Exp $

inherit eutils

DESCRIPTION="programmer's text editor and development environment"
HOMEPAGE="http://zoinks.mikelockwood.com/"
SRC_URI="http://zoinks.mikelockwood.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="nls imlib"

DEPEND="nls? ( sys-devel/gettext )
	imlib? ( media-libs/imlib )
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXext
	x11-libs/libXt"

src_compile() {
	epatch ${FILESDIR}/xorg-library-configure.patch
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
