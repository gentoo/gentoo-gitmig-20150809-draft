# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-meme/embassy-meme-0.1.0.ebuild,v 1.1 2007/07/18 01:43:22 ribosome Exp $

EBOV="5.0.0"

inherit embassy

DESCRIPTION="EMBOSS integrated version of MEME - Multiple Em for Motif Elicitation"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	mirror://gentoo/embassy-${EBOV}-${PN:8}-${PV}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

src_install() {
	embassy_src_install
	insinto /usr/include/emboss/meme
	doins src/INCLUDE/*.h
}
