# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/yagtd/yagtd-0.3.2.ebuild,v 1.1 2010/05/19 21:02:11 bangert Exp $

EAPI="2"

inherit distutils eutils

DESCRIPTION="CLI todo list manager based on the 'Getting Things Done' philosophy."
HOMEPAGE="https://gna.org/projects/yagtd/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	#fix doc install location
	sed -i -e "s:\/doc\/yagtd:\/doc\/${P}:g" setup.py || die
	#dont try to install missing file
	epatch "${FILESDIR}"/${P}-fix-install-setup.py.diff
}

src_install() {
	distutils_src_install
	dosym /usr/bin/yagtd.py /usr/bin/yagtd
}
