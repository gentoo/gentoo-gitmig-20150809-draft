# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-selinux/python-selinux-2.10.ebuild,v 1.1 2003/11/21 05:58:47 pebenito Exp $

DESCRIPTION="Python bindings for SELinux functions"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="sys-libs/libselinux"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	mkdir -p ${S}
	bzcat ${FILESDIR}/${P}.c.bz2 > ${S}/selinux.c
}

src_compile() {
	cd ${S}
	einfo "Compiling selinux.so"
	gcc -fPIC -shared -o selinux.so -I /usr/include/python2.2/ selinux.c -lselinux || die
}

src_install() {
	insinto /usr/lib/python2.2/site-packages
	doins selinux.so
}
