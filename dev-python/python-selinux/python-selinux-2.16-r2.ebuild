# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-selinux/python-selinux-2.16-r2.ebuild,v 1.1 2006/02/27 01:25:30 pebenito Exp $

inherit python

DESCRIPTION="Extra python bindings for SELinux functions"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
LICENSE="GPL-2"
SLOT="0"
SRC_URI="mirror://gentoo/${P}-1.tar.bz2"

KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/python
	>=sys-libs/libselinux-1.28-r1"

S=${WORKDIR}/${PN}

src_compile() {
	cd ${S}
	python_version
	emake
}

src_install() {
	python_version
	make DESTDIR="${D}" install
}
