# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/checkpolicy/checkpolicy-1.16.ebuild,v 1.5 2004/10/07 23:21:42 pebenito Exp $

IUSE=""

inherit eutils

DESCRIPTION="SELinux policy compiler"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"

DEPEND="sys-libs/libsepol
	sys-devel/flex
	sys-devel/bison"

RDEPEND="sec-policy/selinux-base-policy"

src_unpack() {
	unpack ${A}
	sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" -e 's/$(LIBS)/$(LIBS) $(LDFLAGS)/' ${S}/Makefile
	sed -i -e '/^lex\.yy\.c/s/\.l/\.l y\.tab\.c/' ${S}/Makefile
	epatch ${FILESDIR}/checkpolicy-1.16-no-netlink-warn.diff

	# MLS support is experimental!
#	use mls && sed -i -e '/^MLS/s/n/y/' ${S}/Makefile
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
