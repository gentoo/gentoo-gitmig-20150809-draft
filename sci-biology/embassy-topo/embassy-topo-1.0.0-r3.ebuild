# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-topo/embassy-topo-1.0.0-r3.ebuild,v 1.3 2006/11/02 22:34:44 grobian Exp $

EBOV="4.0.0"

inherit embassy

DESCRIPTION="EMBOSS integrated version of TOPO - Transmembrane protein display"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	mirror://gentoo/embassy-${EBOV}-${PN:8}-${PV}.tar.gz"

KEYWORDS="~ppc x86"
