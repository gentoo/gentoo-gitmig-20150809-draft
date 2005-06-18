# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pth/pth-2.0.3.ebuild,v 1.7 2005/06/18 00:42:06 vapier Exp $

inherit eutils fixheadtails

DESCRIPTION="GNU Portable Threads"
HOMEPAGE="http://www.gnu.org/software/pth/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	ht_fix_file configure
}

src_compile() {
	econf || die "econf failed"
	# note - needed so parallel compile works
	emake pth_p.h || die "pth_p.h make failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ANNOUNCE AUTHORS ChangeLog NEWS README THANKS USERS
}
