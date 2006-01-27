# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zmysqlda/zmysqlda-2.0.8.ebuild,v 1.9 2006/01/27 02:51:11 vapier Exp $

inherit zproduct

DESCRIPTION="A MySQL Database Adapter(DA) for zope"
HOMEPAGE="http://sourceforge.net/projects/mysql-python"
SRC_URI="mirror://sourceforge/mysql-python/ZMySQLDA-${PV}.tar.gz"

LICENSE="|| ( GPL-2 CNRI )"
KEYWORDS="~ppc x86"

RDEPEND=">=dev-python/mysql-python-0.9.2"

S=${WORKDIR}/lib/python/Products

ZPROD_LIST="ZMySQLDA"
