# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/talksoup/talksoup-1.0_alpha1.ebuild,v 1.2 2007/08/18 15:26:54 angelos Exp $

inherit gnustep

MY_P="TalkSoup-1.0alpha"
S=${WORKDIR}/${MY_P}

DESCRIPTION="IRC client for GNUstep"
HOMEPAGE="http://talksoup.aeruder.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-1"

IUSE=""
DEPEND="${GS_DEPEND}
	>=gnustep-libs/netclasses-1.05"
RDEPEND="${GS_RDEPEND}
	>=gnustep-libs/netclasses-1.05"

egnustep_install_domain "Local"
