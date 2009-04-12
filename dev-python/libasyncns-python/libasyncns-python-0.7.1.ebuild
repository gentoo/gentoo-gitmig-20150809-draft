# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libasyncns-python/libasyncns-python-0.7.1.ebuild,v 1.2 2009/04/12 20:51:11 hanno Exp $

inherit distutils

DESCRIPTION="Python bindings for libasyncns."
HOMEPAGE="https://launchpad.net/libasyncns-python/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND=">=net-libs/libasyncns-0.4"
RDEPEND="${DEPEND}"
