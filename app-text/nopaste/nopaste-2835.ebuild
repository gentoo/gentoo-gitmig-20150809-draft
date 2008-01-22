# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/nopaste/nopaste-2835.ebuild,v 1.1 2008/01/22 15:29:57 ulm Exp $

inherit eutils

DESCRIPTION="command-line interface to rafb.net/paste"
HOMEPAGE="http://n01se.net/agriffis/nopaste"
SRC_URI="${HOMEPAGE}/${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc-fbsd ~sparc ~x86 ~x86-fbsd"
IUSE="X"

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/ruby
	X? ( x11-misc/xclip )"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}/${P}" ${PN}
	epatch "${FILESDIR}/${P}-output-redirect.patch"
}

src_install() {
	dobin ${PN} || die
}
