# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/paxtest/paxtest-0.9.7_pre5.ebuild,v 1.1 2009/06/29 22:32:39 idl0r Exp $

inherit eutils multilib

MY_P=${P/_/-}

DESCRIPTION="PaX regression test suite"
HOMEPAGE="http://pax.grsecurity.net"
SRC_URI="http://grsecurity.net/~paxguy1/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-apps/chpax-0.7
	sys-apps/paxctl"

# EI_PAX flags are not strip safe.
RESTRICT="strip"

S=${WORKDIR}/${MY_P}

QA_EXECSTACK="usr/$(get_libdir)/${PN}/shlibdata
	usr/$(get_libdir)/${PN}/shlibbss
	usr/$(get_libdir)/${PN}/rettofunc1x
	usr/$(get_libdir)/${PN}/rettofunc2x
	usr/$(get_libdir)/${PN}/rettofunc1
	usr/$(get_libdir)/${PN}/rettofunc2
	usr/$(get_libdir)/${PN}/writetext
	usr/$(get_libdir)/${PN}/mprotshdata
	usr/$(get_libdir)/${PN}/mprotshbss
	usr/$(get_libdir)/${PN}/mprotstack
	usr/$(get_libdir)/${PN}/mprotheap
	usr/$(get_libdir)/${PN}/mprotdata
	usr/$(get_libdir)/${PN}/mprotbss
	usr/$(get_libdir)/${PN}/mprotanon
	usr/$(get_libdir)/${PN}/execstack
	usr/$(get_libdir)/${PN}/execheap
	usr/$(get_libdir)/${PN}/execdata
	usr/$(get_libdir)/${PN}/execbss
	usr/$(get_libdir)/${PN}/anonmap"

src_unpack() {
	unpack ${A}
	cd "${S}"

	mv Makefile.psm Makefile || die
	epatch "${FILESDIR}/${P}-Makefile.patch" \
		"${FILESDIR}/${P}-missing-includes.patch"
}

src_compile() {
	emake RUNDIR=/usr/$(get_libdir)/paxtest || die
}

src_install() {
	make DESTDIR="${D}" BINDIR=/usr/bin RUNDIR=/usr/$(get_libdir)/paxtest install || die

	newman debian/manpage.1.ex paxtest.1 || die
	dodoc ChangeLog README || die
}
