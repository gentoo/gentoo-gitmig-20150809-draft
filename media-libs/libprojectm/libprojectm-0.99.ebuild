# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libprojectm/libprojectm-0.99.ebuild,v 1.5 2007/03/08 00:35:37 weeve Exp $

MY_PN="${PN/libprojectm/libprojectM}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A graphical music visualization plugin similar to milkdrop"
HOMEPAGE="http://xmms-projectm.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-projectm/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="media-libs/ftgl
	media-libs/freetype
	virtual/opengl
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}"

src_install() {
	emake DESTDIR="${D}" install || die
}
