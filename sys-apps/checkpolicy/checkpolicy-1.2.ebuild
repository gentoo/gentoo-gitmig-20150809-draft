# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/checkpolicy/checkpolicy-1.2.ebuild,v 1.4 2003/10/29 16:08:39 method Exp $

IUSE=""

DESCRIPTION="SELinux policy compiler"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="sys-devel/flex
	sys-devel/bison"

RDEPEND="${DEPEND}
	sec-policy/selinux-base-policy"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-1.2-gentoo.diff
}

src_compile() {
	cd ${S}
	emake EXTRA_CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR="${D}" install
}
