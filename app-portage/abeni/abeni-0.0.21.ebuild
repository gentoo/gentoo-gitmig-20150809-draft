# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/abeni/abeni-0.0.21.ebuild,v 1.1 2004/11/04 23:57:10 pythonhead Exp $

inherit distutils

DESCRIPTION="Integrated Development Environment for Gentoo Linux ebuilds"
HOMEPAGE="http://abeni.sf.net/"
SRC_URI="mirror://sourceforge/abeni/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/python
	>=dev-python/wxpython-2.4.2.4
	>=sys-apps/portage-2.0.46-r12
	>=app-portage/gentoolkit-0.1.30"

src_install() {
	distutils_src_install
	insinto /usr/share/abeni
	doins abenirc
	insinto /usr/share/abeni/templates
	doins template/*
	insinto /usr/share/abeni/priv_funcs
	doins docs/priv_funcs/*
	cd docs
	dodoc TODO ChangeLog README COPYING CREDITS
}

