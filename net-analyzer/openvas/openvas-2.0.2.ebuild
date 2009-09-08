# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas/openvas-2.0.2.ebuild,v 1.1 2009/09/08 11:21:21 hanno Exp $

DESCRIPTION="A remote security scanner"
HOMEPAGE="http://www.openvas.org/"
DEPEND=">=net-analyzer/openvas-libraries-2.0.4
	>=net-analyzer/openvas-libnasl-2.0.2
	>=net-analyzer/openvas-server-2.0.3
	>=net-analyzer/openvas-plugins-1.0.7
	>=net-analyzer/openvas-client-2.0.5"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
