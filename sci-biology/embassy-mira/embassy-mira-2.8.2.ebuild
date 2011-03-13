# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-mira/embassy-mira-2.8.2.ebuild,v 1.3 2011/03/13 12:57:48 armin76 Exp $

EBOV="6.0.1"

inherit embassy

DESCRIPTION="Fragment assembly add-on package for EMBOSS"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	mirror://gentoo/embassy-${EBOV}-${PN:8}-${PV}.tar.gz"

KEYWORDS="amd64 ~ppc x86"
