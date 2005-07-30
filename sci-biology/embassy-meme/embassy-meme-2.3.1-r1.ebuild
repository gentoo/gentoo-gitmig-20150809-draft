# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-meme/embassy-meme-2.3.1-r1.ebuild,v 1.5 2005/07/30 00:41:21 ribosome Exp $

inherit embassy-2.10

DESCRIPTION="EMBOSS integrated version of MEME - Multiple Em for Motif Elicitation"

KEYWORDS="ppc ppc-macos x86"

src_install() {
	embassy-2.10_src_install
	insinto /usr/include/emboss/meme
	doins src/INCLUDE/*.h
}
