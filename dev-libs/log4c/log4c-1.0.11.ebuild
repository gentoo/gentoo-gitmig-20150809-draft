# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4c/log4c-1.0.11.ebuild,v 1.6 2004/11/21 08:58:37 dragonheart Exp $

inherit eutils

DESCRIPTION="Log4c is a library of C for flexible logging to files, syslog and other destinations. It is modeled after the Log for Java library (http://jakarta.apache.org/log4j/), staying as close to their API as is reasonable."
SRC_URI="mirror://sourceforge/log4c/${P}.tar.gz"
HOMEPAGE="http://log4c.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc ~ppc"
IUSE="doc"

DEPEND="doc? ( >=app-doc/doxygen-1.2.15
		virtual/tetex
		virtual/ghostscript )
	sys-devel/autoconf
	>=media-gfx/graphviz-1.7.15-r2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/makefile.doc.am.patch || die "failed to patch"
	epatch ${FILESDIR}/makefile.doc.in.patch || die "failed to patch"
	epatch ${FILESDIR}/configure.in.patch || die "failed to patch"
	epatch ${FILESDIR}/log4c_1.0.11_test.patch  || die "failed to patch"
	epatch ${FILESDIR}/${P}-function.patch || die "failed to patch"
}

src_compile() {


	#local myconf
	#if has maketest ${FEATURES} || use maketest;
	#then
	#	myconf="${myconf} --enable-test"
	#fi

	autoconf
	econf --enable-test `use_enable doc` || die
	use doc && addwrite "${ROOT}/var/cache/fonts"
	emake || die
}

src_test() {
	${S}/tests/log4c/test_category || die "test_rc failed"
}

src_install() {
	emake DESTDIR=${D} install
	prepalldocs.new || prepalldocs
}
