# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-meme/embassy-meme-2.3.1.ebuild,v 1.1 2004/12/23 23:02:39 ribosome Exp $

inherit embassy

DESCRIPTION="EMBOSS integrated version of MEME - Multiple Em for Motif Elicitation"

KEYWORDS="x86 ~ppc"

src_install() {
	embassy_src_install
	insinto /usr/include/emboss/meme
	doins src/INCLUDE/*.h
}
