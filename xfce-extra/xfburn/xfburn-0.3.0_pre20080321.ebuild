# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfburn/xfburn-0.3.0_pre20080321.ebuild,v 1.1 2008/03/21 07:36:46 drac Exp $

inherit xfce44

xfce44

DESCRIPTION="GTK+ based CD and DVD burning application"
HOMEPAGE="http://www.xfce.org/projects/xfburn"
SRC_URI="http://dev.gentooexperimental.org/~drac/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug minimal"

RDEPEND=">=dev-libs/libburn-0.4.2
	>=dev-libs/libisofs-0.6.2.1
	>=xfce-extra/exo-0.3.2
	!minimal? ( >=xfce-base/thunar-${THUNAR_MASTER_VERSION} )
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable !minimal thunar-vfs) 
		--disable-dependency-tracking"
}
