# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/wefts/wefts-0.99c-r1.ebuild,v 1.2 2006/01/09 00:09:19 flameeyes Exp $

inherit eutils

MY_P="lib${P}"

DESCRIPTION="A C++ high-level yet efficent multithreading library, portable across pthread-enabled platforms."

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://wefts.sourceforge.net/"

DEPEND="doc? ( app-doc/doxygen )
	sys-devel/autoconf
	sys-devel/automake"
RDEPEND=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE="doc debug"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-errno.patch
	epatch ${FILESDIR}/${PN}-m_ret.patch
	epatch ${FILESDIR}/${PN}-order.patch

	cp ${FILESDIR}/testsuite.h ${S}/testsuite

	./autogen.sh || die "autogen failed"
	libtoolize --copy --force
}

src_compile() {
	hasq maketest ${FEATURES} && \
		myconf="${myconf} --enable-suite"

	econf \
		$(use_enable doc) \
		$(use_enable debug) \
		${myconf} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_test() {
	einfo "Please ignore failures on test #5, it's platform-dependant."

	cd ${S}/testsuite
	./testsuite || die "Some tests failed."
}

src_install () {
	make DESTDIR=${D} install || die

	if use doc; then
		dohtml -r ${S}/doc/html/*
	fi
}

