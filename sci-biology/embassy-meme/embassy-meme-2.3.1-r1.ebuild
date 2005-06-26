# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-meme/embassy-meme-2.3.1-r1.ebuild,v 1.4 2005/06/26 21:06:15 j4rg0n Exp $

inherit embassy-2.10

DESCRIPTION="EMBOSS integrated version of MEME - Multiple Em for Motif Elicitation"

KEYWORDS="ppc ppc-macos x86"

src_install() {
	embassy_src_install
	insinto /usr/include/emboss/meme
	doins src/INCLUDE/*.h
}
