# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pth/pth-2.0.3.ebuild,v 1.1 2005/01/19 20:52:58 dragonheart Exp $

inherit fixheadtails

DESCRIPTION="GNU Portable Threads"
HOMEPAGE="http://www.gnu.org/software/pth/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc-macos ~sparc ~x86 ~ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	ht_fix_file ${S}/configure
}

src_compile() {
	econf || die "econf failed"
	# note - needed so parallel compile works
	emake pth_p.h || die "pth_p.h make failed"
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR=${D} install || die
	dodoc ANNOUNCE AUTHORS ChangeLog NEWS README THANKS USERS
}
