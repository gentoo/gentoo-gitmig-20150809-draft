# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcdaudio/libcdaudio-0.99.9.ebuild,v 1.4 2004/01/06 04:03:19 brad_mssw Exp $

inherit flag-o-matic

DESCRIPTION="Library of cd audio related routines."
SRC_URI="mirror://sourceforge/libcdaudio/${P}.tar.gz"
HOMEPAGE="http://libcdaudio.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa ~mips ~amd64"

src_compile() {
	# -fPIC is required for this library on alpha, see bug #17192
	use alpha && append-flags -fPIC

	econf --enable-threads --with-gnu-ld
	emake || die "compile problem."
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangLog NEWS README README.BeOS README.OSF1 TODO
}
