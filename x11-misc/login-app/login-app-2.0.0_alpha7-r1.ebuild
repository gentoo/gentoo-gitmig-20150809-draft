# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/login-app/login-app-2.0.0_alpha7-r1.ebuild,v 1.2 2005/06/17 22:30:27 swegener Exp $

inherit eutils

_P=Login.app-2.0.0-Alpha-7
S=${WORKDIR}/${_P}

DESCRIPTION="Graphical Login Utility"
SRC_URI="http://largo.windowmaker.org/files/Login.app/${_P}.tar.gz"
HOMEPAGE="http://largo.windowmaker.org/Login.app/"
DEPEND=">=x11-libs/libPropList-0.10.1
	>=sys-libs/zlib-1.1.4
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2
	>=media-libs/tiff-3.5.7
	>=media-libs/libungif-4.1.0
	>=x11-wm/windowmaker-0.91.0-r1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

src_unpack() {

	unpack ${A}
	cd ${S}

	## Fixes a function rename in the wrlib 
	## library of windowmaker
	epatch ${FILESDIR}/${PN}-windowmaker.patch

}

src_compile() {
	emake || die
}

src_install () {
	make \
		INSTALL_DIR=${D}/${GNUSTEP_LOCAL_ROOT:-/usr/lib/GNUstep}/Apps/Login.app \
		install
	dodoc README* TODO COPYING
}
