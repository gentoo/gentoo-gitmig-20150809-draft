# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4/xfce4-4.1.90.ebuild,v 1.1 2004/10/04 18:48:12 bcowan Exp $

IUSE=""

DESCRIPTION="Xfce 4 base ebuild"
SRC_URI=""
HOMEPAGE="http://xfce.org"

LICENSE="GPL-2 BSD LGPL-2"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~ppc ~alpha ~sparc ~amd64 ~hppa ~mips"

RDEPEND="=xfce-base/xfce4-base-${PV}
	>=xfce-extra/xfce4-battery-0.1.1
	>=xfce-extra/xfce4-systemload-0.3.2
	>=xfce-extra/xfce4-minicmd-0.1.1
	>=xfce-extra/xfce4-netload-0.1.3
	>=xfce-extra/xfce4-cpugraph-0.2.2
	>=xfce-extra/xfce4-taskbar-0.1.0
	>=xfce-extra/xfce4-windowlist-0.1.0"
DEPEND="!<xfce-base/xfce4-4.1.90"