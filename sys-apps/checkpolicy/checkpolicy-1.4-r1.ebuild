# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/checkpolicy/checkpolicy-1.4-r1.ebuild,v 1.2 2004/01/26 21:45:24 pebenito Exp $

IUSE=""

DESCRIPTION="SELinux policy compiler"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="sys-devel/flex
	sys-devel/bison"

RDEPEND="sec-policy/selinux-base-policy"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/checkpolicy-1.4-negset.diff
	sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" Makefile
}

src_compile() {
	cd ${S}
	emake YACC="bison -y" || die
}

src_install() {
	make DESTDIR="${D}" install
}
