# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcdaudio/libcdaudio-0.99.9.ebuild,v 1.10 2004/07/16 02:57:17 tgall Exp $

inherit flag-o-matic gnuconfig

DESCRIPTION="Library of cd audio related routines."
SRC_URI="mirror://sourceforge/libcdaudio/${P}.tar.gz"
HOMEPAGE="http://libcdaudio.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ~mips ~amd64 ia64 ppc64"
IUSE=""

src_compile() {
	# -fPIC is required for this library on alpha, see bug #17192
	use alpha && append-flags -fPIC
	use ppc64 && gnuconfig_update

	econf --enable-threads --with-gnu-ld || die "econf failed"
	emake || die "compile problem."
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangLog NEWS README README.BeOS README.OSF1 TODO
}
