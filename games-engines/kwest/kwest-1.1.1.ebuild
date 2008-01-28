# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/kwest/kwest-1.1.1.ebuild,v 1.2 2008/01/28 01:11:31 mr_bones_ Exp $

ARTS_REQUIRED=yes #bug #207816
inherit kde
need-kde 3

DESCRIPTION="An Inform interactive fiction interpreter for KDE"
HOMEPAGE="http://kwest.sourceforge.net/"
SRC_URI="mirror://sourceforge/kwest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${PN}
