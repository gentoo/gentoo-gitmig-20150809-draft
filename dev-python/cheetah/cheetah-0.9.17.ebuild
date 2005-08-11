# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cheetah/cheetah-0.9.17.ebuild,v 1.3 2005/08/11 01:07:29 metalgod Exp $

inherit distutils

MY_P=${P/ch/Ch}

DESCRIPTION="Python-powered template engine and code generator."
HOMEPAGE="http://www.cheetahtemplate.org/"
SRC_URI="mirror://sourceforge/cheetahtemplate/${MY_P}.tar.gz"
LICENSE="PSF-2.2"
IUSE=""
KEYWORDS="alpha ~amd64 ppc ppc-macos sparc x86"
SLOT="0"
DEPEND=">=dev-lang/python-2.2"
S=${WORKDIR}/${MY_P}

PYTHON_MODNAME="Cheetah"
DOCS="README CHANGES TODO"

