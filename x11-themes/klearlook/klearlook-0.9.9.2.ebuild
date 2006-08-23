# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/klearlook/klearlook-0.9.9.2.ebuild,v 1.3 2006/08/23 19:40:25 carlo Exp $

ARTS_REQUIRED="never"
inherit kde

DESCRIPTION="A clearlooks lookalike style for KDE"
HOMEPAGE="http://www.devsoft.com/~jck/"
SRC_URI="http://www.devsoft.com/~jck/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86-fbsd ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
need-kde 3.4