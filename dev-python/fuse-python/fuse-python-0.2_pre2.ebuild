# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fuse-python/fuse-python-0.2_pre2.ebuild,v 1.1 2008/04/21 19:47:01 jokey Exp $

inherit distutils

# Upstream version is -pre2
MY_P=${P/_/-}

S="${WORKDIR}/${MY_P}"

KEYWORDS="~amd64 ~x86"
DESCRIPTION="Python FUSE bindings"
HOMEPAGE="http://fuse.sourceforge.net/wiki/index.php/FusePython"
SRC_URI="mirror://sourceforge/fuse/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=dev-lang/python-2.3
		>=sys-fs/fuse-2.0"
