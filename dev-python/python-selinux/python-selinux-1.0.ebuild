# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-selinux/python-selinux-1.0.ebuild,v 1.1 2003/07/04 01:05:44 method Exp $

DESCRIPTION="Python bindings for SELinux functions"
HOMEPAGE="http://selinux.dev.gentoo.org/python"
SRC_URI="http://selinux.dev.gentoo.org/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE="selinux"

DEPEND="sys-apps/selinux-small"
RDEPEND="sys-apps/selinux-small"

S=${WORKDIR}/${P}

src_compile() {
	gcc -shared -o selinux.so -I /usr/include/python2.2/ selinux.c -lsecure
}

src_install() {
	cp selinux.so /usr/lib/python2.2/site-packages
}
