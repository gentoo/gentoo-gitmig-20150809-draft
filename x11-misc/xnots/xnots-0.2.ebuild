# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xnots/xnots-0.2.ebuild,v 1.3 2009/01/08 22:30:26 nelchael Exp $

EAPI="2"

DESCRIPTION="A desktop sticky note program for the unix geek"
HOMEPAGE="http://xnots.sourceforge.net"
SRC_URI="mirror://sourceforge/xnots/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/pango[X]"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	NO_DEBUG=1 emake || die
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr mandir=/usr/share/man install || die
}

pkg_postinst() {
	elog "xNots requires INOTIFY support present in kernel."
	elog "Please make sure you have enabled CONFIG_INOTIFY in your config."
}
