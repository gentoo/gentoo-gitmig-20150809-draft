# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/takcd/takcd-0.10.ebuild,v 1.12 2007/01/23 00:27:06 seemant Exp $

WANT_AUTOMAKE="1.4"
WANT_AUTOCONF="2.5"

inherit autotools

IUSE=""

DESCRIPTION="Command line CD player"
HOMEPAGE="http://bard.sytes.net/takcd/"
SRC_URI="http://bard.sytes.net/takcd/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc sparc x86"

src_unpack() {
	unpack ${A}
	cd "${S}"

	eautoreconf
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog NEWS README* TODO
}
