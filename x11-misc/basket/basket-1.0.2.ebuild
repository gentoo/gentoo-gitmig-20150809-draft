# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basket/basket-1.0.2.ebuild,v 1.5 2008/02/19 12:21:23 ingmar Exp $

inherit kde

IUSE="crypt"

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
SRC_URI="http://basket.kde.org/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

DEPEND="crypt? ( >=app-crypt/gpgme-1.0 )"
RDEPEND="${DEPEND}"

need-kde 3.3

src_unpack() {
	kde_src_unpack

	sed -e "s/x-basket-template/&;/" -i "${S}/src/${PN}.desktop" || die "Sed failed."
}
