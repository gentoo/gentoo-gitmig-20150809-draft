# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/libvisual-projectm/libvisual-projectm-0.99.ebuild,v 1.1 2006/11/06 23:31:01 flameeyes Exp $

MY_PN="${PN/projectm/projectM}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A libvisual graphical music visualization plugin similar to milkdrop"
HOMEPAGE="http://xmms-projectm.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-projectm/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="=media-libs/libvisual-0.4*
	=media-libs/libprojectm-0.99*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}"

src_install() {
	emake DESTDIR="${D}" install || die
}
