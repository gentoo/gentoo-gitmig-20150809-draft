# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/thinkeramik/thinkeramik-3.2.1.ebuild,v 1.12 2006/10/09 21:54:40 deathwing00 Exp $

inherit kde

DESCRIPTION="A cool kde style modified from keramik"
SRC_URI="http://prefsx1.hp.infoseek.co.jp/tk040429/${P}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=10919"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="x86 ppc ~amd64 ~sparc"

ARTS_REQUIRED="never"

DEPEND="|| ( kde-base/kwin kde-base/kdebase )"

RDEPEND="${DEPEND}"

need-kde 3.2

