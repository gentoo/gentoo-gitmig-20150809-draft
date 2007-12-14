# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libopenraw/libopenraw-0.0.3.ebuild,v 1.2 2007/12/14 18:36:59 drac Exp $

inherit autotools eutils

DESCRIPTION="Decoding library for RAW image formats"
HOMEPAGE="http://libopenraw.freedesktop.org"
SRC_URI="http://${PN}.freedesktop.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk"

RDEPEND="dev-libs/boost
	media-libs/jpeg
	gtk? ( >=x11-libs/gtk+-2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# http://bugs.freedesktop.org/show_bug.cgi?id=13658
	sed -i -e 's:LDFLAGS:LIBS:g' m4/ax_boost_unit_test_framework.m4

	# http://bugs.freedesktop.org/show_bug.cgi?id=13659
	epatch "${FILESDIR}"/${P}-disable-ljpegtest.patch

	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf $(use_enable gtk gnome)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
