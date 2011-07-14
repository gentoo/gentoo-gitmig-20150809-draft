# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rbtools/rbtools-0.3.2.ebuild,v 1.1 2011/07/14 21:37:00 dilfridge Exp $

EAPI=3
PYTHON_DEPEND=2
RESTRICT_PYTHON_ABIS="3.*"

inherit versionator distutils

MY_PN=RBTools
MY_P=${MY_PN}-${PV}

DESCRIPTION="Command line tools for use with Review Board"
HOMEPAGE="http://www.reviewboard.org/"
SRC_URI="http://downloads.reviewboard.org/releases/${MY_PN}/$(get_version_component_range 1-2)/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}/${MY_P}
