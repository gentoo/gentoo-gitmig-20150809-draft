# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylibpcap/pylibpcap-0.4.ebuild,v 1.8 2005/01/29 21:16:55 dragonheart Exp $

inherit distutils

DESCRIPTION="Python interface to libpcap"
HOMEPAGE="http://sourceforge.net/projects/${PN}/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/python
	virtual/libpcap"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
