# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kpasscard/kpasscard-0.1.2.ebuild,v 1.3 2003/09/08 07:07:44 msterret Exp $

inherit kde-base
need-kde 3

DESCRIPTION="KPasscard is a kde application for storing several passwords to a chipcard encrypted by a master password."
HOMEPAGE="http://www.tobias-bayer.de/en/kpasscard.html"
SRC_URI="http://download.berlios.de/kpasscard/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="$DEPEND
	>=libchipcard-0.6"

RDEPEND="${DEPEND}"

