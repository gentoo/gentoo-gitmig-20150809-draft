# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/kwest/kwest-1.0.ebuild,v 1.11 2008/01/28 01:11:31 mr_bones_ Exp $

ARTS_REQUIRED=yes #bug #207816
inherit kde
need-kde 3

DESCRIPTION="An Inform interactive fiction interpreter for KDE"
HOMEPAGE="http://users.pandora.be/peter.bienstman/kwest/"
SRC_URI="http://users.pandora.be/peter.bienstman/kwest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc"
IUSE=""
