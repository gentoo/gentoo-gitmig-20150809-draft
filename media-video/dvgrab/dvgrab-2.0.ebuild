# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvgrab/dvgrab-2.0.ebuild,v 1.2 2007/01/06 00:18:55 aballier Exp $

WANT_AUTOCONF=2.5
WANT_AUTOMAKE=1.9

inherit eutils autotools

DESCRIPTION="Digital Video (DV) grabber for GNU/Linux"
HOMEPAGE="http://www.kinodv.org/"
SRC_URI="mirror://sourceforge/kino/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="jpeg quicktime"

DEPEND=">=sys-libs/libraw1394-1.1.0
	>=media-libs/libdv-0.103
	>=media-libs/libiec61883-1.0.0
	sys-libs/libavc1394
	jpeg? ( media-libs/jpeg )
	quicktime? ( media-libs/libquicktime )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd ${S}
	epatch "${FILESDIR}/${P}-automagic.patch"
	epatch "${FILESDIR}/${P}-asneeded.patch"
	epatch "${FILESDIR}/${PN}-libquicktime-compat.patch"
	eautoreconf
}

src_compile() {
	econf $(use_with quicktime libquicktime) \
		$(use_with jpeg libjpeg) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO NEWS || die "dodoc failed"
}
