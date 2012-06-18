# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/laternamagica/laternamagica-0.4.ebuild,v 1.1 2012/06/18 19:27:55 voyageur Exp $

EAPI=4
inherit gnustep-2

MY_P="LaternaMagica-${PV}"
DESCRIPTION="an image viewer and slideshow application"
HOMEPAGE="http://gap.nongnu.org/laternamagica/index.html"
SRC_URI="http://savannah.nongnu.org/download/gap/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}
