# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fabric/fabric-0.1.1.ebuild,v 1.1 2009/04/24 06:45:22 hollow Exp $

inherit distutils

DESCRIPTION="Fabric is a simple pythonic remote deployment tool"
HOMEPAGE="http://www.nongnu.org/fab/index.html"
SRC_URI="http://savannah.nongnu.org/download/fab/fab-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${DEPEND}
	>=dev-python/paramiko-1.7"
RDEPEND="${DEPEND}"

S="${WORKDIR}/fab-${PV}"
