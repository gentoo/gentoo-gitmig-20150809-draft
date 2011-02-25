# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ted/ted-2.20.ebuild,v 1.8 2011/02/25 18:18:48 signals Exp $

EAPI=2
inherit eutils

DESCRIPTION="X-based rich text editor"
HOMEPAGE="http://www.nllgg.nl/Ted"
SRC_URI="ftp://ftp.nluug.nl/pub/editors/ted/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="x11-libs/gtk+
	>=media-libs/tiff-3.5.7
	virtual/jpeg
	>=media-libs/libpng-1.2.3"
RDEPEND="${DEPEND}"

S=${WORKDIR}/Ted-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng14.patch

	sed -i -e 's|/Ted/|/share/Ted/|' \
		"${S}"/appFrame/appFrameConfig.h.in \
		"${S}"/Ted/tedConfig.h.in || die
	mkdir lib || die
}

src_configure() {
	for dir in appFrame appUtil bitmap docBuf ind Ted tedPackage
	do
		cd "${S}"/${dir}
		econf --cache-file=../config.cache || die "configure ${dir} failed"
	done
}

src_compile() {
	emake package.shared || die "make package.shared failed"
}

src_install() {
	cd "${S}"/tedPackage
	RPM_BUILD_ROOT=${D} ./installTed.sh COMMON || die "install failed"

	dodir /usr/share
	mv "${D}"usr/Ted "${D}"usr/share/Ted
}
