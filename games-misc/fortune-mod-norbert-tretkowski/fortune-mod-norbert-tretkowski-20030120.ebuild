# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-norbert-tretkowski/fortune-mod-norbert-tretkowski-20030120.ebuild,v 1.4 2004/12/28 17:50:00 josejx Exp $

S="${WORKDIR}/fortune-mod-norbert.tretkowski-${PV}"

DESCRIPTION="Quotes from Norbert Tretkowski"
HOMEPAGE="http://fortune-mod-fvl.sourceforge.net/"
SRC_URI="mirror://sourceforge/fortune-mod-fvl/${S}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc hppa alpha"
IUSE=""

RDEPEND="games-misc/fortune-mod"

src_install () {
	cd "${S}"
	insinto /usr/share/fortune
	doins norbert.tretkowski norbert.tretkowski.dat
}
