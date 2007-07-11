# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyrtf/pyrtf-0.45.ebuild,v 1.4 2007/07/11 06:19:48 mr_bones_ Exp $

inherit distutils

MY_P=${P/pyrtf/PyRTF}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A set of python classes that make it possible to produce RTF
documents from python programs."
SRC_URI="mirror://sourceforge/$PN/${MY_P}.tar.gz"
HOMEPAGE="http://pyrtf.sourceforge.net"

KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
SLOT="0"
LICENSE="|| ( GPL-2 LGPL-2 )"
IUSE=""

DEPEND=""
