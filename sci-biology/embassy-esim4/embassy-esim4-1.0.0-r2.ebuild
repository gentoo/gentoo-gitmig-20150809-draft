# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-esim4/embassy-esim4-1.0.0-r2.ebuild,v 1.7 2006/11/02 22:24:56 grobian Exp $

EBOV="3.0.0"

inherit embassy

DESCRIPTION="EMBOSS integrated version of sim4 - Alignment of cDNA and genomic DNA"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/old/${EBOV}/EMBOSS-${EBOV}.tar.gz
	ftp://emboss.open-bio.org/pub/EMBOSS/old/${EBOV}/${EF}.tar.gz"

RESTRICT="mirror"

KEYWORDS="ppc x86"
