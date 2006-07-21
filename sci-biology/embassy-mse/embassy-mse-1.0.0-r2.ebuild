# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-mse/embassy-mse-1.0.0-r2.ebuild,v 1.5 2006/07/21 00:23:56 ribosome Exp $

EBOV="3.0.0"

inherit embassy

DESCRIPTION="EMBOSS integrated version of MSE - Multiple Sequence Screen Editor"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/old/${EBOV}/EMBOSS-${EBOV}.tar.gz
	ftp://emboss.open-bio.org/pub/EMBOSS/old/${EBOV}/${EF}.tar.gz"

KEYWORDS="ppc ppc-macos x86"

RESTRICT="mirror"

src_install() {
	embassy_src_install
	insinto /usr/include/emboss/mse
	doins h/*.h
}
