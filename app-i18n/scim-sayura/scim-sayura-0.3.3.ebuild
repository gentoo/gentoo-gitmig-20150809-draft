# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-sayura/scim-sayura-0.3.3.ebuild,v 1.2 2010/06/23 15:05:56 hwoarang Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Sayura Sinhala input method for SCIM"
HOMEPAGE="http://www.sayura.net/im/"
SRC_URI="http://www.sayura.net/im/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=app-i18n/scim-0.99.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/scim-sayura-0.3.3-gcc45.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README
	dohtml doc/index.html doc/style.css
	use doc && dodoc doc/sayura.pdf
}
