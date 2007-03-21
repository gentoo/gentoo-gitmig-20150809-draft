# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/aquamarine/aquamarine-0.2.1.ebuild,v 1.1 2007/03/21 03:02:37 tsunam Exp $

inherit kde

DESCRIPTION="Beryl KDE Window Decorator"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="~x11-wm/beryl-core-${PV}
	|| ( kde-base/kdebase kde-base/kwin )"

need-kde 3.5
