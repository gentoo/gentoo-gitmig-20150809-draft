# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/canna-2ch/canna-2ch-20030827.ebuild,v 1.13 2006/10/21 00:14:47 flameeyes Exp $

inherit cannadic eutils

DESCRIPTION="Japanese Canna dictionary for 2channelers"
HOMEPAGE="http://omaemona.sourceforge.net/packages/Canna/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
#SRC_URI="http://omaemona.sourceforge.net/packages/Canna/2ch.t"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ppc64"
IUSE=""

DEPEND=""
# You cannot use 2ch.cbd as its name. Canna doesn't load dictionaries
# if the name begins with number. (I don't know why ...)
CANNADICS="2ch"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-canna36p4-gentoo.patch"
}

src_compile() {
	mkbindic nichan.ctd || die
}
