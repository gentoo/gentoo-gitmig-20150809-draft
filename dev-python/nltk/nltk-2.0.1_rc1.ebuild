# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nltk/nltk-2.0.1_rc1.ebuild,v 1.1 2011/10/10 18:52:12 hwoarang Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P=${P/_rc/rc}
DESCRIPTION="Natural Language Toolkit"
SRC_URI="http://nltk.googlecode.com/files/${MY_P}.zip"
HOMEPAGE="http://nltk.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/pyyaml"
RDEPEND="$DEPEND
	dev-python/numpy"

S=${WORKDIR}/${MY_P}
