# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-selinux/python-selinux-2.16.ebuild,v 1.5 2006/02/09 00:27:40 pebenito Exp $

inherit python

DESCRIPTION="Python bindings for SELinux functions"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
LICENSE="GPL-2"
SLOT="0"
SRC_URI="mirror://gentoo/${P}.c.bz2"

KEYWORDS="~alpha amd64 mips ppc sparc x86"
#KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~mips"
IUSE=""

DEPEND="dev-lang/python
	sys-libs/libselinux"

S=${WORKDIR}/${PN}

src_unpack() {
	mkdir -p ${S}
	bzcat ${DISTDIR}/${A} > ${S}/selinux.c || die
}

src_compile() {
	cd ${S}
	python_version
	einfo "Compiling selinux.so for python ${PYVER}"
	gcc -fPIC -shared -o selinux.so -I /usr/include/python${PYVER}/ selinux.c -lselinux || die
}

src_install() {
	python_version
	insinto /usr/lib/python${PYVER}/site-packages
	doins selinux.so
}
