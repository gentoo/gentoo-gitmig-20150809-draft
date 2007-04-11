# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/shrip/shrip-0.3.0.ebuild,v 1.1 2007/04/11 13:26:30 beandog Exp $

DESCRIPTION="Command line tool for ripping DVDs and encoding to AVI/OGM/MKV/MP4"
HOMEPAGE="http://ogmrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/ogmrip/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-libs/glib-2.6
	>=media-video/ogmrip-0.10.0
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	myconf="$(use_enable debug maintainer-mode)"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog README TODO

	insinto /etc
	doins shrip.conf
}
