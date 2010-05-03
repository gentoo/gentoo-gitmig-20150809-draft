# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/uwsgi/uwsgi-0.9.5.ebuild,v 1.1 2010/05/03 19:24:28 hollow Exp $

EAPI="3"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"

inherit eutils python toolchain-funcs

DESCRIPTION="uWSGI server for Python web applications"
HOMEPAGE="http://projects.unbit.it/uwsgi/"
SRC_URI="http://projects.unbit.it/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}"

src_prepare() {
	# Python 3 requires constant indentation.
	epatch "${FILESDIR}/${PN}-0.9.5-fix_uwsgiconfig.py_indentation.patch"

	# Respect CC, CFLAGS and LDFLAGS.
	epatch "${FILESDIR}/${PN}-0.9.5-respect_flags.patch"

	python_copy_sources
}

src_compile() {
	python_src_compile CC="$(tc-getCC)"
}

src_install() {
	installation() {
		newbin uwsgi uwsgi-${PYTHON_ABI}
	}
	python_execute_function -s installation

	python_generate_wrapper_scripts "${ED}usr/bin/uwsgi"
}
