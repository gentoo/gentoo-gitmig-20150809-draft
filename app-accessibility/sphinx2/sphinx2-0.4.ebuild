# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/sphinx2/sphinx2-0.4.ebuild,v 1.10 2004/11/28 23:10:24 eradicator Exp $

IUSE="static"

inherit eutils gnuconfig

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="CMU Speech Recognition-engine"
HOMEPAGE="http://fife.speech.cs.cmu.edu/sphinx/"
SRC_URI="mirror://sourceforge/cmusphinx/${P}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/sphinx2-gcc3.4.patch
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
