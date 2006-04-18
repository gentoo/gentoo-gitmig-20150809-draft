# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpano12/libpano12-2.7.0.14.ebuild,v 1.2 2006/04/18 01:39:10 halcy0n Exp $

inherit eutils

DESCRIPTION="Helmut Dersch's panorama toolbox library"
HOMEPAGE="http://panotools.sf.net"
SRC_URI="mirror://sourceforge/panotools/libpano12-${PV}.tar.bz2"
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

#src_unpack() {
#	unpack ${A}
#	cd ${S}
#	autoconf
#	libtoolize --force --copy
#}

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
