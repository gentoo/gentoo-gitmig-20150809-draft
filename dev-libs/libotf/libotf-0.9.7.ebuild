# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libotf/libotf-0.9.7.ebuild,v 1.4 2008/06/15 06:34:03 zmedico Exp $

WANT_AUTOMAKE=latest
WANT_AUTOCONF=latest

inherit autotools

DESCRIPTION="Library for handling OpenType fonts (OTF)"
HOMEPAGE="http://www.m17n.org/libotf/"
SRC_URI="http://www.m17n.org/libotf/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="X"

RDEPEND=">=media-libs/freetype-2.1
	X? (
		x11-libs/libXaw
		x11-libs/libICE
	)"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use X || sed -i -e '/^bin_PROGRAMS/s/otfview//' example/Makefile.am || die
	eautomake
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS NEWS README ChangeLog
}

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-0.9.3"
	previous_less_than_0_9_3=$?
}

pkg_postinst() {
	if [[ $previous_less_than_0_9_3 = 0 ]] ; then
		ewarn
		ewarn "Shared library extension has been changed. You may need to recompile"
		ewarn "everything depending on this library (in short, please remerge m17n-lib"
		ewarn " if you are upgrading)."
		ewarn
	fi
}
