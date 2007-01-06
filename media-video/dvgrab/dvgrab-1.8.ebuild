# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvgrab/dvgrab-1.8.ebuild,v 1.10 2007/01/06 00:18:55 aballier Exp $

inherit eutils autotools

DESCRIPTION="Digital Video (DV) grabber for GNU/Linux"
HOMEPAGE="http://www.kinodv.org/"
SRC_URI="mirror://sourceforge/kino/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="jpeg quicktime"

DEPEND="sys-libs/libavc1394
	>=media-libs/libdv-0.102
	jpeg? ( media-libs/jpeg )
	quicktime? ( media-libs/libquicktime )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${P}-configure.patch"
	cd ${S}
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
