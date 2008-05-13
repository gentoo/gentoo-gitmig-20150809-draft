# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/ipodslave/ipodslave-0.7.3.ebuild,v 1.4 2008/05/13 13:38:55 josejx Exp $

inherit kde eutils

IUSE=""
DESCRIPTION="KDE ioslave for managing the Apple iPod"
HOMEPAGE="http://sourceforge.net/projects/kpod"
SRC_URI="mirror://sourceforge/kpod/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"

DEPEND="media-libs/id3lib"

need-kde 3.2
