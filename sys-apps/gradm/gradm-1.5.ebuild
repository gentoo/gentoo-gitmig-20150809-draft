# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-1.5.ebuild,v 1.1 2002/09/21 18:39:04 vapier Exp $

DESCRIPTION="ACL administrative interface to grsecurity"
SRC_URI="http://www.grsecurity.net/${P}.tar.gz
	http://pageexec.virtualave.net/chpax.c"
HOMEPAGE="http://www.grsecurity.net/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="sys-devel/bison
	sys-devel/flex"
RDEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	cp ${DISTDIR}/chpax.c .

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
	chmod 700 ${D}/sbin/gradm ${D}/sbin/chpax
}
