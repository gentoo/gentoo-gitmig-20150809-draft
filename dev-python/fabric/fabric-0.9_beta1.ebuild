# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fabric/fabric-0.9_beta1.ebuild,v 1.1 2009/09/10 22:10:17 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="${PN}-${PV/_beta/b}"

DESCRIPTION="Fabric is a simple pythonic remote deployment tool"
HOMEPAGE="http://www.nongnu.org/fab/index.html"
# Snapshots are generated on-the-fly and checksums vary, so
# only download the snapshot from Gentoo mirrors.
#SRC_URI="http://git.fabfile.org/cgit.cgi/fabric/snapshot/${MY_P}.tar.gz"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/paramiko-1.7"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"
