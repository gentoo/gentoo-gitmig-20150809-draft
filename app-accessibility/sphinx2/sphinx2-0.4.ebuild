# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/sphinx2/sphinx2-0.4.ebuild,v 1.7 2004/09/24 15:54:29 blubb Exp $

inherit eutils gnuconfig

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="CMU Speech Recognition-engine"
HOMEPAGE="http://fife.speech.cs.cmu.edu/sphinx/"
SRC_URI="mirror://sourceforge/cmusphinx/${P}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/sphinx2-gcc3.4.patch
	if use amd64 ; then
		gnuconfig_update
	fi
}

src_install() {
	einstall || die
}
