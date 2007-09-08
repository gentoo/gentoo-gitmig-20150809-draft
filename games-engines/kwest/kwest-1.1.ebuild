# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/kwest/kwest-1.1.ebuild,v 1.1 2007/09/08 07:17:27 mr_bones_ Exp $

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
