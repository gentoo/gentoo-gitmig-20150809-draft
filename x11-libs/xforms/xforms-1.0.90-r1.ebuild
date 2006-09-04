# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xforms/xforms-1.0.90-r1.ebuild,v 1.6 2006/09/04 14:22:05 gustavoz Exp $

DESCRIPTION="A graphical user interface toolkit for X"
HOMEPAGE="http://www.nongnu.org/xforms/"
SRC_URI="http://savannah.nongnu.org/download/xforms/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm ppc ~ppc-macos sh sparc x86"
IUSE="opengl"

DEPEND=" || (
				(
					x11-libs/libICE
					x11-libs/libXpm
					x11-libs/libSM
					x11-proto/xproto
				)
				virtual/x11
			 )
	opengl? ( virtual/opengl )
	media-libs/jpeg"


src_compile () {
	local myopts
	if ! use opengl; then myopts="--disable-gl"; fi
	econf ${myopts} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog INSTALL NEWS README
}
