# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header

DESCRIPTION="Sphinx2 - CMU Speech Recognition-engine"
HOMEPAGE="http://fife.speech.cs.cmu.edu/sphinx/"
MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
SRC_URI="mirror://sourceforge/cmusphinx/${P}.tar.gz"
SLOT="0"
LICENSE="BSD as-is"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die

}
