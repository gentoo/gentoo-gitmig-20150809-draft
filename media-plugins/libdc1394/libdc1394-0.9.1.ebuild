# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/libdc1394/libdc1394-0.9.1.ebuild,v 1.5 2004/07/24 05:59:10 eradicator Exp $

DESCRIPTION="libdc1394 is a library that is intended to provide a high level programming interface for application developers who wish to control IEEE 1394 based cameras that conform to the 1394-based Digital Camera Specification (found at http://www.1394ta.org/)"
HOMEPAGE="http://sourceforge.net/projects/libdc1394/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=sys-libs/libraw1394-0.9.0"

DEPEND="${RDEPEND}
	sys-devel/libtool"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc NEWS README AUTHORS
}
