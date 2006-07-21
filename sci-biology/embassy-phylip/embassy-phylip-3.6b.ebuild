# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-phylip/embassy-phylip-3.6b.ebuild,v 1.5 2006/07/21 00:25:38 ribosome Exp $

EBOV="3.0.0"

inherit embassy

DESCRIPTION="EMBOSS integrated version of the PHYLogeny Inference Package"
LICENSE="freedist"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/old/${EBOV}/EMBOSS-${EBOV}.tar.gz
	ftp://emboss.open-bio.org/pub/EMBOSS/old/${EBOV}/${EF}.tar.gz"

RESTRICT="mirror"

KEYWORDS="ppc ppc-macos x86"
