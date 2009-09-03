# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fabric/fabric-0.9a_p3.ebuild,v 1.2 2009/09/03 07:39:15 zmedico Exp $

inherit distutils

MYPV=${PV/_p/}

DESCRIPTION="Fabric is a simple pythonic remote deployment tool"
HOMEPAGE="http://www.nongnu.org/fab/index.html"
# Snapshots are generated on-the-fly and checksums vary, so
# only download the snapshot from gentoo mirrors.
#SRC_URI="http://git.fabfile.org/cgit.cgi/fabric/snapshot/${PN}-${MYPV}.tar.gz"
SRC_URI="mirror://gentoo/${PN}-${MYPV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${DEPEND}
	>=dev-python/paramiko-1.7"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MYPV}"
