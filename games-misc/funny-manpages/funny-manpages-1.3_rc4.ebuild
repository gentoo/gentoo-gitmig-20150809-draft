# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/funny-manpages/funny-manpages-1.3_rc4.ebuild,v 1.2 2004/02/20 06:43:59 mr_bones_ Exp $

inherit eutils

MY_R="4"
MY_P="${PN}_${PV/_rc4/}"
DESCRIPTION="funny manpages collected from various sources"
HOMEPAGE="http://debian.org/"
SRC_URI="http://ftp.debian.org/debian/pool/main/f/funny-manpages/${MY_P}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/f/funny-manpages/${MY_P}-${MY_R}.diff.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="sys-apps/man"

S="${WORKDIR}/${MY_P/_/-}.orig"

src_unpack() {
	unpack ${A}
	epatch ${MY_P}-${MY_R}.diff
}

src_install() {
	doman *
}
