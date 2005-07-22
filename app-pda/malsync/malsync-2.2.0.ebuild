# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/malsync/malsync-2.2.0.ebuild,v 1.6 2005/07/22 17:21:23 dholm Exp $

inherit eutils

MY_P=${P/-/_}
DESCRIPTION="A command line tool that allows Palm Pilots to synchronize to the AvantGo.com server"
HOMEPAGE="http://www.tomw.org/malsync/"
SRC_URI="http://www.tomw.org/malsync/${MY_P}.src.tar.gz"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=app-pda/pilot-link-0.11.7"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/Makefile-pilot-link.diff
}

src_compile() {
	emake || die
}

src_install() {
	dobin malsync || die
	dodoc Doc/*
}
