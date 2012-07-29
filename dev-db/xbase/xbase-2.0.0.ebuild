# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xbase/xbase-2.0.0.ebuild,v 1.20 2012/07/29 18:19:41 armin76 Exp $

inherit base eutils

DESCRIPTION="xbase (i.e. dBase, FoxPro, etc.) compatible C++ class library"
HOMEPAGE="http://www.rekallrevealed.org/"
SRC_URI="http://www.rekallrevealed.org/packages/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 hppa ppc ppc64 x86 ~x86-fbsd"
IUSE="doc"

# !media-tv/linuxtv-dvb-apps (bug #208596)
RDEPEND="!media-tv/linuxtv-dvb-apps"
DEPEND="${DEPEND}
	sys-devel/automake
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_install() {
	base_src_install
	dodoc AUTHORS Changelog INSTALL NEWS README TODO
	if use doc; then
		rm html/Makefile*
		dohtml html/*
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.cpp examples/Makefile.95
	fi
}
