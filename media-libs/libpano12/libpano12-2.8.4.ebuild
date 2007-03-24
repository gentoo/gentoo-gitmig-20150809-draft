# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpano12/libpano12-2.8.4.ebuild,v 1.2 2007/03/24 20:35:09 armin76 Exp $

inherit eutils

DESCRIPTION="Helmut Dersch's panorama toolbox library"
HOMEPAGE="http://panotools.sf.net"
SRC_URI="mirror://sourceforge/panotools/libpano12-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos x86"
IUSE="java"
DEPEND="media-libs/libpng
		media-libs/tiff
		media-libs/jpeg
		sys-libs/zlib
		java? ( virtual/jdk )"

S="${WORKDIR}/libpano12-${PV}"

src_compile() {
	local myconf=""
	use java \
		&& myconf="--with-java=${JAVA_HOME}"
	use java \
		|| myconf="--without-java"
	econf ${myconf} || die "Configure failed"
	emake || die "Build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc README README.linux AUTHORS NEWS doc/*.txt
}
