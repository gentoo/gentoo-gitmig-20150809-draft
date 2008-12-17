# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gdevilspie/gdevilspie-0.31.ebuild,v 1.2 2008/12/17 04:57:20 ssuominen Exp $

inherit distutils

DESCRIPTION="A user friendly interface to the devilspie window matching daemon, to create rules easily."
HOMEPAGE="http://code.google.com/p/gdevilspie/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2
	x11-misc/devilspie"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="gDevilspie"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:doc/gdevilspie:doc/${PF}:" setup.py || die "sed failed."
}
