# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/bwidget/bwidget-1.7.0.ebuild,v 1.8 2012/06/07 20:39:34 zmedico Exp $

inherit eutils multilib

DESCRIPTION="high-level widget set for Tcl/Tk completely written in Tcl"

MY_PN=${PN/bw/BW}
MY_P=${MY_PN}-${PV}
HOMEPAGE="http://tcllib.sourceforge.net/"
SRC_URI="mirror://sourceforge/tcllib/${MY_P}.tar.gz"
IUSE="doc"
LICENSE="BWidget"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"

DEPEND="dev-lang/tk
		dev-lang/tcl"

S=${WORKDIR}/${MY_P}

src_install() {
	cd ${S}
	insinto /usr/$(get_libdir)/${P}
	doins *.tcl
	cp -R images lang ${D}usr/$(get_libdir)/${P}
	dodoc ChangeLog LICENSE.txt README.txt
	cp -R demo ${D}usr/share/doc/${PF}/
	use doc && dohtml BWman/*
}
