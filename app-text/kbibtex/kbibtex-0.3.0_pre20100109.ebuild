# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbibtex/kbibtex-0.3.0_pre20100109.ebuild,v 1.2 2010/01/06 10:13:36 ssuominen Exp $

EAPI=2
WEBKIT_REQUIRED=always
inherit kde4-base

DESCRIPTION="A BibTeX editor for KDE to edit bibliographies used with LaTeX"
HOMEPAGE="http://home.gna.org/kbibtex/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="virtual/tex-base"
