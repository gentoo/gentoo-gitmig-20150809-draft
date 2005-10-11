# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.3.5-r3.ebuild,v 1.2 2005/10/11 15:11:17 greg_g Exp $

inherit kde kde-functions eutils

# TODO : mysql support
# other refs from configure: jasper, qt-docs, doxygen, libxml2, libxslt, freetype, fontconfig, qt being built with sql support (???)

DESCRIPTION="A free, integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
SRC_URI="mirror://kde/stable/${P}/src/${P}.tar.bz2
	mirror://kde/security_patches/post-koffice-1.3.5-rtfimport.diff"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc x86"

IUSE=""
SLOT="0"
# add blockers on split packages derived from this one
for x in $(get-child-packages ${CATEGORY}/${PN}); do
	DEPEND="${DEPEND} !${x}"
	RDEPEND="${RDEPEND} !${x}"
done

DEPEND="${DEPEND}
	>=dev-lang/python-2.2.1
	>=media-libs/libart_lgpl-2.3.9
	>=media-gfx/imagemagick-5.4.5
	>=app-text/wv2-0.1.8
	dev-util/pkgconfig"
need-kde 3.1

PATCHES="${FILESDIR}/koffice_1_3_xpdf_buffer_overflow.diff
	${FILESDIR}/CAN-2005-0064.patch
	${DISTDIR}/post-koffice-1.3.5-rtfimport.diff"

src_compile() {
	export LIBPYTHON="`python-config --libs`"
	kde_src_compile
}
