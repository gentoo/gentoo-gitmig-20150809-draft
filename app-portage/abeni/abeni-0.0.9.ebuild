# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/abeni/abeni-0.0.9.ebuild,v 1.7 2004/07/03 12:08:41 kloeri Exp $

inherit distutils

DESCRIPTION="Integrated Development Environment for Gentoo Linux ebuilds"
HOMEPAGE="http://abeni.sf.net/"
SRC_URI="mirror://sourceforge/abeni/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="virtual/python
	>=dev-python/wxpython-2.4.1.2
	>=sys-apps/portage-2.0.46-r12
	>=app-portage/gentoolkit-0.1.30
	>=dev-python/gadfly-1.0.0"

pkg_setup() {
	if [ ! -f "/usr/bin/wxgtk-2.4-config" ]; then
		eerror "You MUST emerge wxGTK, and wxpython without gtk2 support! Do:"
		eerror "USE='-gtk2' emerge wxGTK wxpython"
		die "gtk2 not supported"
	fi
}


src_install() {
	distutils_src_install
	dodoc TODO ChangeLog INSTALL COPYING CREDITS
	insinto /usr/share/abeni
	doins abenirc
	doins templates
}
