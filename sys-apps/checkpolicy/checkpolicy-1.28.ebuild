# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/checkpolicy/checkpolicy-1.28.ebuild,v 1.6 2006/02/22 17:07:43 spb Exp $

IUSE=""

inherit eutils

SEMNG_VER="1.4"

DESCRIPTION="SELinux policy compiler"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 mips ppc sparc x86"

DEPEND="=sys-libs/libsemanage-${SEMNG_VER}*
	sys-devel/flex
	sys-devel/bison"

src_unpack() {
	unpack ${A}
	cd ${S}

	# this can probably be removed (1.28+)
	#sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" -e 's/$(LIBS)/$(LIBS) $(LDFLAGS)/' ${S}/Makefile
	#sed -i -e '/^lex\.yy\.c/s/\.l/\.l y\.tab\.c/' ${S}/Makefile
}

src_compile() {
	cd ${S}
	emake YACC="bison -y" || die
}

src_install() {
	make DESTDIR="${D}" install
}

pkg_postinst() {
	einfo "This checkpolicy can compile version `checkpolicy -V |cut -f 1 -d ' '` policy."
}
