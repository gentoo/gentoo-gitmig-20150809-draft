# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/calltree/calltree-0.9.7-r1.ebuild,v 1.2 2004/09/16 15:48:47 caleb Exp $

inherit eutils

DESCRIPTION="A plugin for cachegrind that adds call-graph profiling, needed by kcachegrind"
HOMEPAGE="http://kcachegrind.sourceforge.net/"
SRC_URI="http://kcachegrind.sourceforge.net/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RDEPEND="=dev-util/valgrind-2.1.2"
DEPEND="${RDEPEND} sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	# valgrind 2.1.2 support
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/calltree-0.9.7-valgrind2.1.2.patch
	cd ${S}
	WANT_AUTOCONF=2.5
	autoconf
}

src_install() {
	einstall                     || die
	rm -rf ${D}/usr/share/doc/valgrind
	dodoc AUTHORS INSTALL README || die "dodoc failed"
	dohtml docs/*.html           || die "dohtml failed"
}
