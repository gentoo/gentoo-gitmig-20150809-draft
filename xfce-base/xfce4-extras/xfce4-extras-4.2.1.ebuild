# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-extras/xfce4-extras-4.2.1.ebuild,v 1.2 2005/03/24 09:32:07 pylon Exp $

DESCRIPTION="Xfce 4 extras ebuild"
LICENSE="GPL-2 BSD LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=">=xfce-base/xfce4-${PV}
	>=xfce-extra/xfce4-showdesktop-0.4.0-r1
	>=xfce-extra/xfce4-battery-0.2.0-r1
	>=xfce-extra/xfce4-systemload-0.3.4-r1
	>=xfce-extra/xfce4-minicmd-0.3.0-r1
	>=xfce-extra/xfce4-netload-0.2.3-r1
	>=xfce-extra/xfce4-artwork-0.0.4-r1
	>=xfce-extra/xfce4-clipman-0.4.1-r1
	>=xfce-extra/xfce4-cpugraph-0.2.2-r1
	>=xfce-extra/xfce4-notes-0.9.7-r1
	>=xfce-extra/xfce4-taskbar-0.2.2-r1
	>=xfce-extra/xfce4-windowlist-0.1.0-r1"
XFCE_META=1

inherit xfce4
