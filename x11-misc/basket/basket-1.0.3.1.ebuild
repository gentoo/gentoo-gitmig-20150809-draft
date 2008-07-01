# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basket/basket-1.0.3.1.ebuild,v 1.1 2008/07/01 19:24:56 keytoaster Exp $

inherit kde

IUSE="crypt"

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
SRC_URI="http://basket.kde.org/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="crypt? ( >=app-crypt/gpgme-1.0 )"
RDEPEND="${DEPEND}"

need-kde 3.3

