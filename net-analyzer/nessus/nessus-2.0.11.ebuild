# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus/nessus-2.0.11.ebuild,v 1.3 2004/08/12 19:50:56 eldad Exp $

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
KEYWORDS="-* ppc64"
IUSE=""
