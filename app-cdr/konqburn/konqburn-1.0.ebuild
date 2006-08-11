# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/konqburn/konqburn-1.0.ebuild,v 1.1 2006/08/11 17:55:20 deathwing00 Exp $

inherit kde

DESCRIPTION="The Konqueror CD writing sidebar lets you use your CD/DVD burner
from the konqueror sidebar. K3b provides most of the backend."
HOMEPAGE="http://konqburn.sourceforge.net"
SRC_URI="mirror://sourceforge/konqburn/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="dvdr"

DEPEND="|| ( kde-base/konqueror kde-base/kdebase )
	media-libs/taglib
	app-cdr/k3b" # uses libk3b for burner detection; configure uses it if it's detected
RDEPEND="$DEPEND
	virtual/cdrtools
	dvdr? ( app-cdr/dvd+rw-tools )"

need-kde 3.4

