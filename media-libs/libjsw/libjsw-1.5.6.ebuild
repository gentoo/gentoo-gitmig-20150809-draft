# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjsw/libjsw-1.5.6.ebuild,v 1.6 2007/08/13 21:00:45 dertobi123 Exp $

inherit eutils multilib

DESCRIPTION="provide a uniform API and user configuration for joysticks and game controllers"
HOMEPAGE="http://wolfpack.twu.net/libjsw/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="gtk"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp include/jsw.h libjsw/
	epatch "${FILESDIR}"/${P}-build.patch
	bunzip2 libjsw/man/* jscalibrator/jscalibrator.1.bz2 || die "bunzip failed"
}

src_compile() {
	cd libjsw
	emake || die "main build failed"
	ln -s libjsw.so.${PV} libjsw.so

	if use gtk ; then
		cd ../jscalibrator
		emake || die "jscalibrator failed"
	fi
}

src_install() {
	insinto /usr/include
	doins include/jsw.h || die "doins jsw.h failed"

	dodoc AUTHORS README
	docinto jswdemos
	dodoc jswdemos/*

	cd "${S}"/libjsw
	dolib.so libjsw.so.${PV} || die "dolib.so"
	dosym libjsw.so.${PV} /usr/$(get_libdir)/libjsw.so
	doman man/*

	if use gtk ; then
		cd "${S}"/jscalibrator
		dobin jscalibrator || die
		doman jscalibrator.1
		insinto /usr/share/${PN}
		doins -r data/help
	fi
}
