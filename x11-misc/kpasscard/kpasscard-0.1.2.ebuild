# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kpasscard/kpasscard-0.1.2.ebuild,v 1.6 2004/03/14 17:31:38 mr_bones_ Exp $

inherit kde
need-kde 3

DESCRIPTION="app for storing several passwords to a chipcard encrypted by a master password"
HOMEPAGE="http://www.tobias-bayer.de/en/kpasscard.html"
SRC_URI="http://download.berlios.de/kpasscard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="${DEPEND}
	>=sys-libs/libchipcard-0.6"
