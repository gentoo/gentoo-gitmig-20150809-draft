# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-selinux/python-selinux-2.16-r2.ebuild,v 1.3 2009/08/21 19:55:31 pebenito Exp $

inherit python

DESCRIPTION="Extra python bindings for SELinux functions"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
LICENSE="GPL-2"
SLOT="0"
SRC_URI="mirror://gentoo/${P}-1.tar.bz2"

KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-lang/python
	>=sys-libs/libselinux-1.28-r1"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_compile() {
	python_version
	emake
}

src_install() {
	python_version
	python_need_rebuild
	make DESTDIR="${D}" install
}
