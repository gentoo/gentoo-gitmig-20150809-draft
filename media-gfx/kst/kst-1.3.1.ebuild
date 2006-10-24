# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kst/kst-1.3.1.ebuild,v 1.1 2006/10/24 13:06:45 markusle Exp $

inherit kde

DESCRIPTION="A plotting and data viewing program for KDE."
HOMEPAGE="http://kst.kde.org/"
SRC_URI="mirror://kde/stable/apps/KDE3.x/scientific/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sci-libs/gsl
		>=sci-libs/netcdf-3.6.1-r1"

need-kde 3.5
