# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-powerpuff/fortune-mod-powerpuff-0.3.ebuild,v 1.1 2005/12/20 21:45:37 wolf31o2 Exp $

MY_PN=powerpuff
DESCRIPTION="Quotes taken from the Power Puff Girls series from Cartoon Network"
HOMEPAGE="http://eol.init1.nl/content/view/43/54/"
SRC_URI="http://eelco.is.a.rootboy.net/fortunecookies/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${MY_PN}-${PV}

src_install() {
	insinto /usr/share/fortune
	doins powerpuff powerpuff.dat
}
