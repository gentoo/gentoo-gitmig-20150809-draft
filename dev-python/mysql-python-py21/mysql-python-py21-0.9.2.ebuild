# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/mysql-python-py21/mysql-python-py21-0.9.2.ebuild,v 1.2 2003/06/21 22:30:24 drobbins Exp $

PYTHON_SLOT_VERSION="2.1"
inherit distutils

S="${WORKDIR}/MySQL-python-${PV}"

DESCRIPTION="MySQL Module for python" 
SRC_URI="mirror://sourceforge/mysql-python/MySQL-python-${PV}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/mysql-python/"
LICENSE="GPL-2"
SLOT="0"
DEPEND="virtual/glibc
	>=dev-db/mysql-3.22.19
	${DEPEND}"
RDEPEND="${DEPEND}${RDEPEND}"
KEYWORDS="x86 amd64"
IUSE=""

src_install() {
	distutils_src_install
	dohtml doc/*
}

