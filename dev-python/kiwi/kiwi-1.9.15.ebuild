# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kiwi/kiwi-1.9.15.ebuild,v 1.3 2007/09/07 10:30:58 lu_zero Exp $

NEED_PYTHON=2.3

inherit distutils versionator

DESCRIPTION="Kiwi is a pure Python framework and set of enhanced PyGTK widgets"
HOMEPAGE="http://www.async.com.br/projects/kiwi/"
SRC_URI="http://download.gnome.org/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc examples"

DEPEND=">=dev-python/pygtk-2.8"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:share/doc/kiwi:share/doc/${PF}:g" \
		setup.py || die "sed failed"

	if ! use doc ; then
		sed -i \
			-e '/api/d' \
			-e '/howto/d' \
			setup.py || die "sed failed"
	fi
}

src_install() {
	distutils_src_install
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
