# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-hmmer/embassy-hmmer-2.1.1-r1.ebuild,v 1.1 2005/03/25 01:07:13 ribosome Exp $

inherit embassy-2.10

DESCRIPTION="EMBOSS integrated version of HMMER - Biological sequence analysis with profile HMMs"

KEYWORDS="~x86 ~ppc ~ppc-macos"

src_install() {
	embassy_src_install
	insinto /usr/include/emboss/hmmer
	doins src/*.h
}
