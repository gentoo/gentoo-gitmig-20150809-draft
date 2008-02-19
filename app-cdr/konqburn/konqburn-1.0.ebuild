# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/konqburn/konqburn-1.0.ebuild,v 1.6 2008/02/19 01:06:32 ingmar Exp $

inherit kde

DESCRIPTION="CD/DVD Writer sidebar for Konqueror."
HOMEPAGE="http://konqburn.sourceforge.net"
SRC_URI="mirror://sourceforge/konqburn/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="dvdr"

DEPEND="|| ( =kde-base/konqueror-3.5* =kde-base/kdebase-3.5* )
	media-libs/taglib
	<app-cdr/k3b-1.0" # uses libk3b for burner detection; configure uses it if it's detected
RDEPEND="$DEPEND
	virtual/cdrtools
	dvdr? ( app-cdr/dvd+rw-tools )"

need-kde 3.5
