# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/kbiff/kbiff-3.9.ebuild,v 1.2 2009/10/13 19:30:37 ssuominen Exp $

ARTS_REQUIRED=never
EAPI=2
inherit kde

DESCRIPTION="KDE new mail notification utility (biff)"
HOMEPAGE="http://www.granroth.org/kbiff/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="!${CATEGORY}/${PN}:0"

need-kde 3.5
