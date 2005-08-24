# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/libdc1394/libdc1394-1.0.0.ebuild,v 1.11 2005/08/24 22:55:23 agriffis Exp $

DESCRIPTION="libdc1394 is a library that is intended to provide a high level programming interface for application developers who wish to control IEEE 1394 based cameras that conform to the 1394-based Digital Camera Specification (found at http://www.1394ta.org/)"
HOMEPAGE="http://sourceforge.net/projects/libdc1394/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc ppc64 sparc ~x86"
IUSE=""

DEPEND=">=sys-libs/libraw1394-0.9.0
	sys-devel/libtool
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A} || die
	if ! use X; then
		epatch ${FILESDIR}/nox11.patch
	fi
}

src_install() {
	einstall || die
	dodoc NEWS README AUTHORS
}
