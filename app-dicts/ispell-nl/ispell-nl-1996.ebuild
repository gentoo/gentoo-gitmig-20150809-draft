# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-nl/ispell-nl-1996.ebuild,v 1.2 2007/07/11 05:41:19 mr_bones_ Exp $

MY_P="dutch96"
S="${WORKDIR}/dutch"
DESCRIPTION="A dutch dictionary for ispell"
SRC_URI="ftp://ftp.tue.nl/pub/tex/GB95/ispell-dutch96/dutch96.lat
		ftp://ftp.tue.nl/pub/tex/GB95/ispell-dutch96/dutch96.aff
		ftp://ftp.tue.nl/pub/tex/GB95/ispell-dutch96/dutch93.lat
		ftp://ftp.tue.nl/pub/tex/GB95/ispell-dutch96/README"
HOMEPAGE="http://ficus-www.cs.ucla.edu/geoff/ispell-dictionaries.html"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86 ~amd64"

DEPEND="app-text/ispell"

src_unpack() {
	mkdir ${S}
	cp /usr/portage/distfiles/dutch96.lat ${S}/dutch.lat
	cp /usr/portage/distfiles/dutch93.lat ${S}/dutch93.lat
	cp /usr/portage/distfiles/dutch96.aff ${S}/dutch.aff
}

src_compile() {
	/usr/bin/buildhash -s ${S}/dutch.lat ${S}/dutch.aff ${S}/dutch.hash || die
	/usr/bin/buildhash -s ${S}/dutch93.lat ${S}/dutch.aff ${S}/dutch-93.hash || die
}

src_install () {
	    insinto /usr/lib/ispell
	    doins dutch.aff dutch.hash
	    doins dutch-93.hash
}
