# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pida/pida-0.6.1.ebuild,v 1.1 2010/06/23 23:57:05 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Gtk and/or Vim-based Python Integrated Development Application"
HOMEPAGE="http://pida.co.uk/ http://pypi.python.org/pypi/pida"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="gnome"

RDEPEND="|| ( >=dev-lang/python-2.6 dev-python/simplejson )
	>=app-editors/gvim-6.3
	>=dev-python/anyvc-0.3
	>=dev-python/pygtk-2.8
	dev-python/pygtkhelpers
	gnome? ( >=x11-libs/vte-0.11.11-r2[python] )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix_implicit_declaration.patch"
	emake -C contrib/moo moo-pygtk.c
}

src_install() {
	distutils_src_install
	make_desktop_entry pida Pida pida/resources/pixmaps/pida-icon.png Development
}
