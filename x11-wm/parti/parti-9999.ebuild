# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/parti/parti-9999.ebuild,v 1.1 2010/08/31 12:29:29 xmw Exp $

EAPI=2

PYTHON_DEPEND=2

inherit distutils eutils mercurial python

EHG_REPO_URI="https://partiwm.googlecode.com/hg/"

DESCRIPTION="X Persistent Remote Apps (xpra) and Partitioning WM (parti) based on wimpiggy"
HOMEPAGE="http://partiwm.googlecode.com/"
MY_P="${PN}-all-${PV}"
SRC_URI=""

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="dev-python/pygtk
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXtst"

RDEPEND="${COMMON_RDEPEND}
	dev-python/ipython
	x11-apps/xmodmap"
DEPEND="${COMMON_RDEPEND}
	dev-python/cython
	dev-python/pyrex
	dev-util/pkgconfig"

S=${WORKDIR}/hg

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	if [ ! -e wimpiggy/lowlevel/constants.pxi ] ; then
		cp "${FILESDIR}"/${P}-constants.pxi wimpiggy/lowlevel/constants.pxi || die
	fi
}
