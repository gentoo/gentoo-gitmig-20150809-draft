# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/flite/flite-1.0.ebuild,v 1.3 2004/03/17 22:57:26 dholm Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Flite text to speech engine"
HOMEPAGE="http://www.speech.cs.cmu.edu/flite/index.html"
SRC_URI="http://www.speech.cs.cmu.edu/flite/packed/flite-1.0/${P}-beta.tar.gz"

SLOT="0"
LICENSE="X11"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/glibc"

src_install () {
	cd ${S}/bin
	dobin flite flite_time
}
