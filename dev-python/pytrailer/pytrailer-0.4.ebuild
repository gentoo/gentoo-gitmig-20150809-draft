# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytrailer/pytrailer-0.4.ebuild,v 1.1 2010/10/21 21:30:55 sochotnicky Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS=""

inherit distutils

DESCRIPTION="Module to simplify access to movies on apple.com/trailers"
HOMEPAGE="http://code.google.com/p/pytrailer/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
