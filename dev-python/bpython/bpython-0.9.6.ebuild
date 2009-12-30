# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bpython/bpython-0.9.6.ebuild,v 1.1 2009/12/30 14:06:55 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_USE_WITH="ncurses"

inherit distutils

DESCRIPTION="Syntax highlighting and autocompletion for the Python interpreter"
HOMEPAGE="http://www.bpython-interpreter.org/ https://bitbucket.org/bobf/bpython/ http://pypi.python.org/pypi/bpython"
SRC_URI="http://www.bpython-interpreter.org/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="dev-python/pygments
	dev-python/setuptools
	gtk? ( dev-python/pygtk )"
DEPEND="${RDEPEND}"

DOCS="sample-config sample.theme light.theme"

src_install() {
	distutils_src_install

	if ! use gtk; then
		rm "${D}"usr/bin/bpython-gtk* "${D}"usr/lib*/python*/site-packages/bpython/gtk_.py || die "rm failed"
	fi
}
