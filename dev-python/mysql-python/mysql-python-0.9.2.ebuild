# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mysql-python/mysql-python-0.9.2.ebuild,v 1.13 2005/01/25 14:31:50 fserb Exp $

inherit distutils

S=${WORKDIR}/MySQL-python-${PV}
DESCRIPTION="MySQL Module for python"
HOMEPAGE="http://sourceforge.net/projects/mysql-python/"
SRC_URI="mirror://sourceforge/mysql-python/MySQL-python-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 sparc"
IUSE=""

DEPEND="virtual/python
	virtual/libc
	>=dev-db/mysql-3.22.19"
RDEPEND=""

src_install() {
	distutils_src_install
	dohtml doc/*
}
