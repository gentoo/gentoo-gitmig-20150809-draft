# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basket/basket-0.6.0.ebuild,v 1.5 2007/04/10 19:29:26 troll Exp $

inherit kde

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
SRC_URI="http://basket.kde.org/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE="crypt"

DEPEND="crypt? ( >=app-crypt/gpgme-1.0 )"
RDEPEND="${DEPEND}"

need-kde 3.3

