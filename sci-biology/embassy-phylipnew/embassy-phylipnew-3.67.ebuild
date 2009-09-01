# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-phylipnew/embassy-phylipnew-3.67.ebuild,v 1.2 2009/09/01 18:35:48 ribosome Exp $

EBOV="6.0.1"

inherit embassy

DESCRIPTION="EMBOSS integrated version of PHYLIP - The Phylogeny Inference Package"
LICENSE="freedist"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	mirror://gentoo/embassy-${EBOV}-${PN:8}-${PV}.tar.gz"

KEYWORDS="amd64 ~ppc ~sparc x86"
