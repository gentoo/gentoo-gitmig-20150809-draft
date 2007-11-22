# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/psql/psql-1.10.ebuild,v 1.11 2007/11/22 07:37:02 opfer Exp $

inherit elisp

DESCRIPTION="Mode for editing PostgreSQL SQL"
HOMEPAGE="http://www.hgsc.bcm.tmc.edu/~harley/elisp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-db/postgresql"

SITEFILE=50${PN}-gentoo.el
