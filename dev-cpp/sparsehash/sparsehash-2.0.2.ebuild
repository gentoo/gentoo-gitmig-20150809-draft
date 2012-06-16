# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/sparsehash/sparsehash-2.0.2.ebuild,v 1.1 2012/06/16 08:22:23 dev-zero Exp $

EAPI="4"

DESCRIPTION="An extremely memory-efficient hash_map implementation"
HOMEPAGE="http://code.google.com/p/sparsehash/"
SRC_URI="http://sparsehash.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	default

	# Installs just every piece
	rm -rf "${D}/usr/share/doc"
	dohtml doc/*
}
