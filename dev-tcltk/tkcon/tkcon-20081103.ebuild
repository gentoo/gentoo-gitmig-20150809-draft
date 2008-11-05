# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkcon/tkcon-20081103.ebuild,v 1.1 2008/11/05 21:32:54 bicatali Exp $

inherit eutils

DESCRIPTION="Tk GUI console"
HOMEPAGE="http://tkcon.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc"

DEPEND="dev-lang/tk"

src_install() {
	local tclver="$(echo 'puts $tcl_version' | tclsh)"
	local instdir=/usr/$(get_libdir)/tcl${tclver}/${PN}2.5
	dodir ${instdir}
	cp -pP pkgIndex.tcl tkcon.tcl "${D}"${instdir} || die
	dodir /usr/bin
	dosym ${instdir}/tkcon.tcl /usr/bin/tkcon
	dodoc README.txt
	if use doc; then
		dohtml doc/*
	fi
}
