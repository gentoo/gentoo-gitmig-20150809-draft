# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpgf/libpgf-6.09.44-r1.ebuild,v 1.1 2009/12/29 19:19:52 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Library to load, handle and manipulate images in the PGF format"
HOMEPAGE="http://www.libpgf.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )
	app-arch/unzip"

S=${WORKDIR}/${PN}

src_prepare() {
	if ! use doc; then
		sed -i -e "s/\(SUBDIRS = src include\) doc/\1/g" Makefile.am || die
	fi

	epatch "${FILESDIR}"/${P}-pkg.patch

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
}
