# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eggy/eggy-0.3.3.ebuild,v 1.1 2010/01/11 21:34:59 hwoarang Exp $

EAPI="2"
NEED_PYTHON=2.4
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="An IDE/editor for several programming languages, including Python, Java, C, Perl and others"
HOMEPAGE="http://eggy.yolky.org/eggy/default/about"
SRC_URI="http://eggy.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/PyQt4[X]
	dev-python/qscintilla-python
	dev-python/chardet"
RDEPEND="${DEPEND}"

src_prepare() {
	# remove the bundled chardet library
	sed -i "s:'eggy\\.chardet', ::" setup.py || die "sed failed"
	rm -rf ${P}/${PN}/chardet || die "rm failed"
	distutils_src_prepare
}
