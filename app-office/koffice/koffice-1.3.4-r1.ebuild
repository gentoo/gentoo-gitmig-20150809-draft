# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.3.4-r1.ebuild,v 1.3 2004/11/01 11:23:13 kloeri Exp $

inherit kde eutils

# TODO : mysql support
# other refs from configure: jasper, qt-docs, doxygen, libxml2, libxslt, freetype, fontconfig, qt being built with sql support (???)

DESCRIPTION="A free, integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
SRC_URI="mirror://kde/stable/${P}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86 ~amd64 ppc ~sparc alpha ~ppc64"

IUSE=""
SLOT="0"

DEPEND=">=dev-lang/python-2.2.1
	>=media-libs/libart_lgpl-2.3.9
	>=media-gfx/imagemagick-5.4.5
	>=app-text/wv2-0.1.8
	dev-util/pkgconfig"
need-kde 3.1

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/koffice_1_3_4_xpdf_security_integer_overflow.diff
}
src_compile() {
	export LIBPYTHON="`python-config --libs`"
	kde_src_compile
}
