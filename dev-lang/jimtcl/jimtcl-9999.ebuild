# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/jimtcl/jimtcl-9999.ebuild,v 1.5 2012/05/05 16:51:29 hwoarang Exp $

EAPI="2"

inherit git-2

DESCRIPTION="Small footprint implementation of Tcl programming language"
HOMEPAGE="http://jim.berlios.de/"
EGIT_REPO_URI="http://repo.or.cz/r/jimtcl.git"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="static-libs"

src_configure() {
	! use static-libs && myconf=--with-jim-shared
	econf ${myconf}
}

src_compile() {
	emake all docs || die
}

src_install() {
	dobin jimsh || die "dobin failed"
	use static-libs && {
		dolib.a libjim.a || die "dolib failed"
	} || {
		dolib.so libjim.so || die "dolib failed"
	}
	insinto /usr/include
	doins jim.h jimautoconf.h jim-subcmd.h jim-nvp.h jim-signal.h
	doins jim-win32compat.h jim-eventloop.h jim-config.h
	dodoc AUTHORS README TODO || die "dodoc failed"
	dohtml Tcl.html || die "dohtml failed"
}
