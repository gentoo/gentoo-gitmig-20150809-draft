# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/psql/psql-1.10.ebuild,v 1.15 2010/06/17 19:05:24 patrick Exp $

inherit elisp

DESCRIPTION="Mode for editing PostgreSQL SQL"
HOMEPAGE="http://www.hgsc.bcm.tmc.edu/~harley/elisp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-db/postgresql-server"

SITEFILE="50${PN}-gentoo.el"
