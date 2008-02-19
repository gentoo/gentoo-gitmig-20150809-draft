# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/thinkeramik/thinkeramik-3.2.1.ebuild,v 1.17 2008/02/19 02:15:29 ingmar Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="A cool kde style modified from keramik"
SRC_URI="http://prefsx1.hp.infoseek.co.jp/tk040429/${P}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=10919"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ppc ~sparc x86 ~x86-fbsd"

DEPEND="|| ( =kde-base/kwin-3.5* =kde-base/kdebase-3.5* )"
RDEPEND="${DEPEND}"

need-kde 3.2
