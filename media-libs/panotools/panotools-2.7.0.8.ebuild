# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/panotools/panotools-2.7.0.8.ebuild,v 1.3 2005/02/23 17:40:28 lu_zero Exp $

inherit eutils

DESCRIPTION="Helmut Dersch's panorama toolbox library"
HOMEPAGE="http://panotools.sf.net"
SRC_URI="mirror://sourceforge/panotools/libpano12-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="media-libs/libpng
		media-libs/tiff
		media-libs/jpeg
		sys-libs/zlib
		virtual/jdk"

S="${WORKDIR}/libpano12-${PV}"

src_compile() {
	econf "--with-java=${JAVA_HOME}"
	emake
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README README.linux AUTHORS NEWS doc/*.txt
}
