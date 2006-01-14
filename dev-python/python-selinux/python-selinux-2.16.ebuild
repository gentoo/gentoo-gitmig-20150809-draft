# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-selinux/python-selinux-2.16.ebuild,v 1.3 2006/01/14 01:00:11 spb Exp $

inherit python
python_version

DESCRIPTION="Python bindings for SELinux functions"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~alpha amd64 mips ppc sparc x86"
#KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~mips"
IUSE=""

DEPEND="dev-lang/python
	sys-libs/libselinux"

S=${WORKDIR}/${PN}

src_unpack() {
	mkdir -p ${S}
	bzcat ${FILESDIR}/${P}.c.bz2 > ${S}/selinux.c || die
}

src_compile() {
	cd ${S}
	einfo "Compiling selinux.so for python ${PYVER}"
	gcc -fPIC -shared -o selinux.so -I /usr/include/python${PYVER}/ selinux.c -lselinux || die
}

src_install() {
	insinto /usr/lib/python${PYVER}/site-packages
	doins selinux.so
}
