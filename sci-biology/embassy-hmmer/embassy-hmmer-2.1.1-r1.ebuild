# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-hmmer/embassy-hmmer-2.1.1-r1.ebuild,v 1.5 2005/07/30 00:44:03 ribosome Exp $

inherit embassy-2.10

DESCRIPTION="EMBOSS integrated version of HMMER - Biological sequence analysis with profile HMMs"

KEYWORDS="ppc ppc-macos x86"

src_install() {
	embassy-2.10_src_install
	insinto /usr/include/emboss/hmmer
	doins src/*.h
}
