# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cm/cm-2.4.2.ebuild,v 1.7 2004/09/14 07:26:20 eradicator Exp $

IUSE=""

DESCRIPTION="Common Music: An object oriented music composition environment in LISP/scheme"
HOMEPAGE="http://commonmusic.sourceforge.net"
SRC_URI="mirror://sourceforge/commonmusic/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64"

DEPEND=">=dev-util/guile-1.6.4"

src_install() {
	dodir /usr/share/${PN}
	# the installer part needs the bin dir created
	keepdir /usr/share/${PN}/bin
	dodir /usr/share/${PN}/src
	insinto /usr/share/${PN}/src
	doins ${S}/src/*
	insinto /usr/share/${PN}/src/plotter
	doins ${S}/src/plotter/*
	dodir /usr/share/${PN}/etc
	insinto /usr/share/${PN}/etc
	doins ${S}/etc/*
	dodir /usr/share/${PN}/contrib
	insinto /usr/share/${PN}/contrib
	doins ${S}/etc/contrib/*
	dodir /usr/share/${PN}/examples
	insinto /usr/share/${PN}/examples
	doins ${S}/etc/examples/*
	dohtml -r doc/*
	dodoc ${S}/readme.text ${S}/doc/changelog.text

	newexe ${FILESDIR}/${PN}-2.4.0-exec ${PN}
}
