# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/funny-manpages/funny-manpages-1.3_rc5.ebuild,v 1.5 2004/11/12 18:13:43 blubb Exp $

inherit eutils

MY_R="5"
MY_P="${PN}_${PV/_rc?/}"
DESCRIPTION="funny manpages collected from various sources"
HOMEPAGE="http://debian.org/"
SRC_URI="mirror://debian/pool/main/f/funny-manpages/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/f/funny-manpages/${MY_P}-${MY_R}.diff.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc hppa amd64"
IUSE=""

RDEPEND="sys-apps/man"

S="${WORKDIR}/${MY_P/_/-}.orig"

src_unpack() {
	unpack ${A}
	epatch ${MY_P}-${MY_R}.diff
}

src_install() {
	rm -rf debian
	doman *
}
