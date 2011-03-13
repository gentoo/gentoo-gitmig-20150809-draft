# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-phylipnew/embassy-phylipnew-3.6b.ebuild,v 1.8 2011/03/13 12:58:43 armin76 Exp $

EBOV="4.0.0"

inherit embassy

DESCRIPTION="EMBOSS integrated version of PHYLIP - The Phylogeny Inference Package"
LICENSE="freedist"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	mirror://gentoo/embassy-${EBOV}-${PN:8}-${PV}.tar.gz"

KEYWORDS="~amd64 ppc x86"
