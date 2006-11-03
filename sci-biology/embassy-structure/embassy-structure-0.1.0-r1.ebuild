# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-structure/embassy-structure-0.1.0-r1.ebuild,v 1.4 2006/11/03 09:04:32 je_fro Exp $

EBOV="4.0.0"

inherit embassy

DESCRIPTION="Protein structure add-on package for EMBOSS"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	mirror://gentoo/embassy-${EBOV}-${PN:8}-${PV}.tar.gz"

KEYWORDS="~ppc ~sparc x86"
