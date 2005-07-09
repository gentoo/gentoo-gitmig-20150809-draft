# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/msetimon/msetimon-2.53.ebuild,v 1.1 2005/07/09 18:34:47 smithj Exp $

inherit eutils

MY_PV="${PV/./-}"

DESCRIPTION="Utility for monitoring the SETI@Home client in daemon or GUI mode"
NAME="msetimon"
SRC_URI="mirror://sourceforge/msetimon/${NAME}-perl-source-${MY_PV}.tar.gz"
HOMEPAGE="http://msetimon.sourceforge.net/"

S="${WORKDIR}/${PN}-perl-source-${MY_PV}"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="X"

DEPEND=">=dev-lang/perl-5
	X? ( virtual/x11
		>=dev-perl/perl-tk-8 )"

#RDEPEND="${DEPEND}
#	sci-astronomy/setiathome"

src_unpack() {
	unpack ${A}
	cd ${S}
	use X || epatch "${FILESDIR}/${PN}-daemon-only.patch"
}

src_install() {
	mv msetimon.pl msetimon
	exeinto /usr/bin
	doexe msetimon
	dodoc README_msetimon.txt
}
