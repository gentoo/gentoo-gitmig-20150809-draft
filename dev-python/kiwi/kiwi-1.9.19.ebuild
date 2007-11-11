# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kiwi/kiwi-1.9.19.ebuild,v 1.1 2007/11/11 12:56:43 lucass Exp $

NEED_PYTHON=2.3

inherit distutils versionator

DESCRIPTION="Kiwi is a pure Python framework and set of enhanced PyGTK widgets"
HOMEPAGE="http://www.async.com.br/projects/kiwi/"
SRC_URI="http://download.gnome.org/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="examples"

DEPEND="dev-python/pygtk"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:share/doc/kiwi:share/doc/${PF}:g" \
		setup.py || die "sed failed"
}

src_install() {
	distutils_src_install

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
