# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/fribidi/fribidi-0.10.5.ebuild,v 1.3 2006/09/29 05:44:02 wormo Exp $

inherit eutils libtool

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="http://fribidi.org/"
SRC_URI="http://fribidi.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}"-darwin.patch
	elibtoolize
}

src_compile() {
	econf || die
	emake || die "emake failed"
	make test || die "make test failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS NEWS README ChangeLog THANKS TODO
}
