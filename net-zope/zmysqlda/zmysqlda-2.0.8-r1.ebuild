# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zmysqlda/zmysqlda-2.0.8-r1.ebuild,v 1.1 2004/01/19 14:33:10 lanius Exp $

inherit zproduct

DESCRIPTION="A MySQL Database Adapter(DA) for zope."
HOMEPAGE="http://sourceforge.net/projects/mysql-python"
SRC_URI="http://www.gentoo.at/distfiles/zmysqlda-2.0.8-s2upatch.tar.gz"
LICENSE="GPL-2 | CNRI"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=dev-python/mysql-python-py21-0.9.2
	${RDEPEND}"

ZPROD_LIST="ZMySQLDA"

