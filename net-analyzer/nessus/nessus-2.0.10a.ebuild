# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus/nessus-2.0.10a.ebuild,v 1.2 2004/04/01 14:41:19 jhuebel Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A remote security scanner for Linux"
HOMEPAGE="http://www.nessus.org/"
DEPEND=">=net-analyzer/nessus-libraries-${PV}
	>=net-analyzer/libnasl-${PV}
	>=net-analyzer/nessus-core-${PV}
	>=net-analyzer/nessus-plugins-${PV}"
RDEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
