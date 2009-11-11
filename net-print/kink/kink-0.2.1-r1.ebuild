# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/kink/kink-0.2.1-r1.ebuild,v 1.4 2009/11/11 12:41:24 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde eutils

DESCRIPTION="KDE printer ink level utility monitor"
HOMEPAGE="http://kink.sourceforge.net/"
SRC_URI="mirror://sourceforge/kink/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=net-print/libinklevel-0.7.1"

need-kde 3.5

PATCHES=( "${FILESDIR}/kink-0.2.1-compilefix.diff"
	"${FILESDIR}/${P}-libinklevel-0.6.6.patch"
	"${FILESDIR}/${P}-api-update.patch" )
