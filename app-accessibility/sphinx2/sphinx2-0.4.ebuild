# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/sphinx2/sphinx2-0.4.ebuild,v 1.1 2004/03/17 04:02:25 eradicator Exp $

DESCRIPTION="Sphinx2 - CMU Speech Recognition-engine"
HOMEPAGE="http://fife.speech.cs.cmu.edu/sphinx/"
MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
SRC_URI="mirror://sourceforge/cmusphinx/${P}.tar.gz"
SLOT="0"
LICENSE="BSD as-is"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die

}
