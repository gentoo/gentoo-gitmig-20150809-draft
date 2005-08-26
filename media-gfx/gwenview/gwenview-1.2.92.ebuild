# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gwenview/gwenview-1.2.92.ebuild,v 1.2 2005/08/26 11:39:24 greg_g Exp $

inherit kde

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="image viewer for KDE"
HOMEPAGE="http://gwenview.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="kipi"

DEPEND="kipi? ( >=media-plugins/kipi-plugins-0.1.0_beta2 )"

need-kde 3

src_compile() {
	# Manually remove visibility support,
	# will not be needed in next version.
	export kde_cv_prog_cxx_fvisibility_hidden=no

	local myconf="$(use_enable kipi)"
	kde_src_compile myconf configure
	make || die
}
