# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/plwm/plwm-2.6_alpha.ebuild,v 1.3 2004/06/04 21:16:49 mr_bones_ Exp $

inherit distutils

MY_P="PLWM-${PV/_alpha/a}"
DESCRIPTION="Python classes for, and an implementation of, a window manager."
HOMEPAGE="http://plwm.sourceforge.net/"
SRC_URI="mirror://sourceforge/plwm/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"
IUSE=""
DEPEND=">=dev-lang/python-2.2.2"
RDEPEND=">=dev-lang/python-2.2.2
	>=dev-python/python-xlib-0.12"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	# patch from upstream to make utils useable again
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_install() {
	distutils_src_install

	# do same as old version and make a plwm 'executable'
	# which is examplewm.py
	cp examples/examplewm.py examples/plwm
	dobin examples/plwm
	rm examples/plwm

	# install utils (inspect_plwm, wmm)
	dobin utils/*.py

	# info page
	make -C doc || die "make info docs failed for ${P}"
	doinfo doc/*.info* || die "doinfo failed for ${P}"

	# other docs
	dodoc NEWS ONEWS INSTALL

	docinto examples
	dodoc examples/*

	docinto utils
	dodoc utils/ChangeLog
}
