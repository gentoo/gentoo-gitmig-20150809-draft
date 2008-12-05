# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hcluster/hcluster-0.1.9.ebuild,v 1.1 2008/12/05 13:43:06 bicatali Exp $

inherit distutils

DESCRIPTION="Python hierarchical clustering package based on scipy"
HOMEPAGE="http://code.google.com/p/scipy-cluster/"
SRC_URI="http://scipy-cluster.googlecode.com/files/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

DEPEND="dev-python/numpy"
RDEPEND="dev-python/matplotlib"
