# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4c/log4c-1.0.12.ebuild,v 1.3 2004/11/21 08:58:37 dragonheart Exp $

inherit eutils

DESCRIPTION="Log4c is a library of C for flexible logging to files, syslog and other destinations. It is modeled after the Log for Java library (http://jakarta.apache.org/log4j/), staying as close to their API as is reasonable."
SRC_URI="mirror://sourceforge/log4c/${P}.tar.gz"
HOMEPAGE="http://log4c.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="doc"

DEPEND="doc? ( >=app-doc/doxygen-1.2.15
		virtual/tetex
		virtual/ghostscript )
	>=media-gfx/graphviz-1.7.15-r2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-function.patch
}

src_compile() {

	econf --enable-test `use_enable doc` || die
	use doc && addwrite "${ROOT}/var/cache/fonts"
	emake || die
}

src_test() {
	# test case broken
	#${S}/tests/log4c/test_rc || die "test_rc failed"
	${S}/tests/log4c/test_category || die "test_rc failed"
}

src_install() {
	emake DESTDIR=${D} install
	prepalldocs.new || prepalldocs
}
