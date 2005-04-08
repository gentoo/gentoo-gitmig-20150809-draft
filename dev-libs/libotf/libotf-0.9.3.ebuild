# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libotf/libotf-0.9.3.ebuild,v 1.6 2005/04/08 16:07:48 corsair Exp $

DESCRIPTION="Library for handling OpenType fonts (OTF)"
HOMEPAGE="http://www.m17n.org/libotf/"
SRC_URI="http://www.m17n.org/libotf/${P}.tar.gz"

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="x86 ppc alpha amd64 ppc64 sparc hppa"
IUSE="X"

RDEPEND="X? ( virtual/x11 )
	>=media-libs/freetype-2.1"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	use X || sed -i -e '/^bin_PROGRAMS/s/otfview//' example/Makefile.in || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL NEWS README ChangeLog
}

pkg_postinst() {
	if has_version '<dev-libs/libotf-0.9.3' ; then

	ewarn
	ewarn "Shared library extension has been changed. You may need to recompile"
	ewarn "everything depending on this library (in short, please remerge m17n-lib"
	ewarn " if you are upgrading)."
	ewarn

	fi
}
