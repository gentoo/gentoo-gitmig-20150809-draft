# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/malsync/malsync-2.2.0.ebuild,v 1.1 2003/09/02 21:55:49 liquidx Exp $

MY_P=${P/-/_}

DESCRIPTION="A command line tool that allows Palm Pilots to synchronize to the AvantGo.com server"
HOMEPAGE="http://www.tomw.org/malsync/"
SRC_URI="http://www.tomw.org/malsync/${MY_P}.src.tar.gz"

SLOT="0"
LICENSE="MPL-1.0"
KEYWORDS="~x86"
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
	dobin malsync
	dodoc Doc/*
}
