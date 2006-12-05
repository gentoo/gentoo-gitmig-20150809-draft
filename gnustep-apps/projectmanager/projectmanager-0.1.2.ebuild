# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/projectmanager/projectmanager-0.1.2.ebuild,v 1.1 2006/12/05 21:43:09 grobian Exp $

inherit gnustep

S=${WORKDIR}/${P/projectm/ProjectM}

DESCRIPTION="ProjectManager is another IDE for GNUstep"
HOMEPAGE="http://pmanager.sourceforge.net/"
SRC_URI="mirror://sourceforge/pmanager/${P/projectm/ProjectM}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}
	>=gnustep-base/gnustep-base-1.13.0"
RDEPEND="${GS_RDEPEND}
	>=gnustep-base/gnustep-base-1.13.0"

egnustep_install_domain "Local"
