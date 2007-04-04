# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/konqburn/konqburn-1.0.ebuild,v 1.5 2007/04/04 23:31:46 carlo Exp $

inherit kde

DESCRIPTION="CD/DVD Writer sidebar for Konqueror."
HOMEPAGE="http://konqburn.sourceforge.net"
SRC_URI="mirror://sourceforge/konqburn/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="dvdr"

DEPEND="|| ( kde-base/konqueror kde-base/kdebase )
	media-libs/taglib
	<app-cdr/k3b-1.0" # uses libk3b for burner detection; configure uses it if it's detected
RDEPEND="$DEPEND
	virtual/cdrtools
	dvdr? ( app-cdr/dvd+rw-tools )"

need-kde 3.5
