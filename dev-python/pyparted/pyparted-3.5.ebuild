# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparted/pyparted-3.5.ebuild,v 1.2 2011/03/03 01:22:50 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit autotools python

DESCRIPTION="Python bindings for sys-block/parted"
HOMEPAGE="https://fedorahosted.org/pyparted/"
SRC_URI="https://fedorahosted.org/releases/p/y/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-python/decorator
	>=sys-block/parted-2.3
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/-avoid-version/& -shared /' src/Makefile.am || die "sed failed"
	eautoreconf

	# Disable byte-compilation of Python modules.
	echo "#!/bin/sh" > py-compile

	python_src_prepare
}

src_install() {
	python_src_install
	python_clean_installation_image
	dodoc ChangeLog NEWS README TODO
}

pkg_postinst() {
	python_mod_optimize parted
}

pkg_postrm() {
	python_mod_cleanup parted
}
