# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zmysqlda/zmysqlda-2.0.8.ebuild,v 1.6 2004/10/23 22:42:39 lanius Exp $

inherit zproduct
S="${WORKDIR}/lib/python/Products/"

DESCRIPTION="A MySQL Database Adapter(DA) for zope."
HOMEPAGE="http://sourceforge.net/projects/mysql-python"
SRC_URI="mirror://sourceforge/mysql-python/ZMySQLDA-${PV}.tar.gz"
LICENSE="GPL-2 | CNRI"
KEYWORDS="x86 ~ppc"
RDEPEND=">=dev-python/mysql-python-0.9.2
	${RDEPEND}"

ZPROD_LIST="ZMySQLDA"
IUSE=""
