# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cm/cm-2.4.2.ebuild,v 1.8 2004/10/20 09:22:24 eradicator Exp $

IUSE="doc"

DESCRIPTION="Common Music: An object oriented music composition environment in LISP/scheme"
HOMEPAGE="http://commonmusic.sourceforge.net"
SRC_URI="mirror://sourceforge/commonmusic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64"

DEPEND=">=dev-util/guile-1.6.4"

src_install() {
	newbin ${FILESDIR}/${PN}-2.4.0-exec ${PN}

	# the installer part needs the bin dir created
	keepdir /usr/share/${PN}/bin

	insinto /usr/share/${PN}/src
	doins ${S}/src/*

	insinto /usr/share/${PN}/etc
	doins ${S}/etc/*

	insinto /usr/share/${PN}/contrib
	doins ${S}/etc/contrib/*

	if use doc; then
		insinto /usr/share/doc/${PF}/examples
		doins ${S}/etc/examples/*
		dohtml -r doc/*
	fi

	dodoc ${S}/readme.text ${S}/doc/changelog.text
}
