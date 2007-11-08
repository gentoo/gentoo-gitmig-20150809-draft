# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/nopaste/nopaste-2802.ebuild,v 1.1 2007/11/08 16:11:30 drac Exp $

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

src_unpack() { :; }

src_install() {
	newbin "${DISTDIR}"/${P} ${PN}
}
