# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/esmall/esmall-0.0.1.20030220.ebuild,v 1.2 2003/03/03 14:47:08 vapier Exp $

DESCRIPTION="scripting language for use internally in enlightenment"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc
	sys-devel/gcc"

S=${WORKDIR}/${PN}

src_compile() {
	cp autogen.sh{,.old}
	sed -e 's:.*configure.*::' autogen.sh.old > autogen.sh
	env WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"

	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	insinto /usr/share/${PN}/include
	doins include/*
	insinto /usr/share/${PN}/examples
	doins examples/*
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	dodoc AUTHORS NEWS README
}
