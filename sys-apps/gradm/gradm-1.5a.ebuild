# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-1.5a.ebuild,v 1.2 2003/02/13 15:57:42 vapier Exp $

DESCRIPTION="ACL administrative interface to grsecurity"
SRC_URI="http://www.grsecurity.net/${P}.tar.gz"
HOMEPAGE="http://www.grsecurity.net/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="sys-devel/bison
	sys-devel/flex"
RDEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}

	cd ${S}
	cp ${FILESDIR}/${P}-chpax.c chpax.c

	mv Makefile Makefile.orig
	sed <Makefile.orig >Makefile \
		-e 's|YACC=/usr/bin/yacc|YACC=/usr/bin/bison|' \
		-e 's|$(YACC) -d|$(YACC) -y -d|' \
		-e "s|-O2|${CFLAGS}|"
}

src_compile() {
	emake || die "compile problem"
	emake chpax || die "compile problem"
}

src_install() {
	doman gradm.8
	dodoc acl
	exeinto /etc/init.d
	newexe ${FILESDIR}/grsecurity.rc grsecurity
	insinto /etc/conf.d
	doins ${FILESDIR}/grsecurity
	into /
	dosbin gradm chpax
	fperms 700 /sbin/gradm
	fperms 700 /sbin/chpax
}
