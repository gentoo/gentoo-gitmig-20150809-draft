# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/twolame/twolame-0.3.12.ebuild,v 1.10 2010/08/23 20:24:52 ssuominen Exp $

EAPI=3
inherit libtool

DESCRIPTION="TwoLAME is an optimised MPEG Audio Layer 2 (MP2) encoder"
HOMEPAGE="http://www.twolame.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="static-libs"

RDEPEND=">=media-libs/libsndfile-1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i -e '/CFLAGS/s:-O3::' configure || die
	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" pkgdocdir="/usr/share/doc/${PF}" \
		install || die

	dodoc AUTHORS ChangeLog README TODO
	prepalldocs

	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
