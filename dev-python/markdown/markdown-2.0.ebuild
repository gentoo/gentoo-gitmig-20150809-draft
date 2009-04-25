# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/markdown/markdown-2.0.ebuild,v 1.1 2009/04/25 17:14:14 patrick Exp $

inherit distutils

MY_PN="Markdown"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python implementation of the markdown markup language"
HOMEPAGE="http://www.freewisdom.org/projects/python-markdown"
SRC_URI="http://pypi.python.org/packages/source/M/${MY_PN}/${MY_P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="pygments"

RDEPEND="pygments? ( dev-python/pygments )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	distutils_src_unpack

	# We need to rename the markdown script otherwise imports fail
	cd "${S}"
	for i in markdown.py setup.py MANIFEST markdown/commandline.py ; do
		sed -i 's/markdown.py/markdown-python/' $i || die "sed failed for $i"
	done
	mv markdown.py markdown-python
}

src_install() {
	distutils_src_install
	dodoc docs/*
	docinto extensions
	dodoc docs/extensions/*
}
