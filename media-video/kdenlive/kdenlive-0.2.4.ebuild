# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kdenlive/kdenlive-0.2.4.ebuild,v 1.1 2004/03/18 22:09:08 zypher Exp $

DESCRIPTION="Kdenlive! (pronounced Kay-den-live) is a Non Linear Video Editing Suite for KDE."
HOMEPAGE="http://www.uchian.pwp.blueyonder.co.uk/kdenlive.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE="debug"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

S="${WORKDIR}/${P}"

DEPEND="virtual/x11
	>=x11-libs/qt-3
	>=media-video/piave-0.2.4
	>=kde-base/kdesdk-3.2"

src_compile() {
	
	myconf="--with-gnu-ld --prefix=${KDEDIR}"
	use debug && myconf="${myconf} --enable-debug=yes"
	econf ${myconf} || die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
