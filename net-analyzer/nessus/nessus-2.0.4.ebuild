# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus/nessus-2.0.4.ebuild,v 1.1 2003/04/23 08:51:07 aliz Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A remote security scanner for Linux"
HOMEPAGE="http://www.nessus.org/"
DEPEND="=net-analyzer/nessus-libraries-${PV}
	=net-analyzer/libnasl-${PV}
	=net-analyzer/nessus-core-${PV}
	=net-analyzer/nessus-plugins-${PV}"
RDEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc -sparc"
