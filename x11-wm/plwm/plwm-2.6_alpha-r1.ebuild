# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/plwm/plwm-2.6_alpha-r1.ebuild,v 1.2 2007/08/27 13:44:50 coldwind Exp $

NEED_PYTHON="2.2"

inherit distutils eutils

MY_P="PLWM-${PV/_alpha/a}"
DESCRIPTION="Python classes for, and an implementation of, a window manager."
HOMEPAGE="http://plwm.sourceforge.net/"
SRC_URI="mirror://sourceforge/plwm/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/python-xlib-0.12"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Patch from upstream to make it usable again
	epatch "${FILESDIR}/${P}.patch"

	epatch "${FILESDIR}/${P}-python2.5.patch"
	epatch "${FILESDIR}/${P}-pep0263.patch"
}

src_install() {
	distutils_src_install

	# do same as old version and make a plwm 'executable'
	# which is examplewm.py
	cp examples/examplewm.py examples/plwm
	dobin examples/plwm || die "dobin failed"
	rm examples/plwm

	# install utils (inspect_plwm, wmm)
	dobin utils/*.py || die "dobin failed"

	make -C doc || die "make info docs failed"
	doinfo doc/*.info* || die "doinfo failed"

	dodoc NEWS ONEWS INSTALL || die "dodoc failed"

	docinto examples
	dodoc examples/* || die "dodoc failed"

	docinto utils
	dodoc utils/ChangeLog || die "dodoc failed"
}
