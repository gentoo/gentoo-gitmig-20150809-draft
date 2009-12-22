# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpgf/libpgf-6.09.44.ebuild,v 1.1 2009/12/22 17:53:48 ssuominen Exp $

EAPI=2
inherit autotools

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
	if use ! doc; then
		sed -i \
			-e "s/\(SUBDIRS = src include\) doc/\1/g" Makefile.am || die
	fi

	sed -i \
		-e "s/exec_prefix=@prefix@/exec_prefix=@exec_prefix@/" \
		-e "s/libdir=@prefix@\/lib/libdir=@libdir@/" \
		-e "s/includedir=@prefix@\/include/includedir=@includedir@/" \
			libpgf.pc.in || die

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
}
