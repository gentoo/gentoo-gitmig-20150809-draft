# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pyotr/pyotr-0.1.ebuild,v 1.1 2008/05/16 00:31:59 hanno Exp $

inherit distutils python eutils

DESCRIPTION="Python bindings for OTR encryption"
HOMEPAGE="http://pyotr.pentabarf.de/"
SRC_URI="http://pyotr.pentabarf.de/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-libs/libotr"

src_install() {
	distutils_src_install
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/
	doins otr.py
}
