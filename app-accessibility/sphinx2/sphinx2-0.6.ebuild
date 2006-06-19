# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/sphinx2/sphinx2-0.6.ebuild,v 1.1 2006/06/19 04:59:19 squinky86 Exp $

IUSE="static"

inherit gnuconfig

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="CMU Speech Recognition-engine"
HOMEPAGE="http://fife.speech.cs.cmu.edu/sphinx/"
SRC_URI="mirror://sourceforge/cmusphinx/${P}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	if use amd64 ; then
		gnuconfig_update
	fi
}

src_compile() {
	econf $(use_enable static) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README doc/README.bin doc/README.lib doc/SCHMM_format doc/filler.dict doc/phoneset doc/phoneset-old
	dohtml doc/phoneset_s2.html doc/sphinx2.html
}
