# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/checkpolicy/checkpolicy-1.16.ebuild,v 1.1 2004/09/08 00:42:16 pebenito Exp $

IUSE=""

DESCRIPTION="SELinux policy compiler"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="sys-libs/libsepol
	sys-devel/flex
	sys-devel/bison"

RDEPEND="sec-policy/selinux-base-policy"

src_unpack() {
	unpack ${A}
	sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" -e 's/$(LIBS)/$(LIBS) $(LDFLAGS)/' ${S}/Makefile
}

src_compile() {
	cd ${S}
	emake YACC="bison -y" || die
}

src_install() {
	make DESTDIR="${D}" install
}
