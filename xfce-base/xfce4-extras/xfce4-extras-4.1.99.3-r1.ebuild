# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-extras/xfce4-extras-4.1.99.3-r1.ebuild,v 1.1 2005/01/06 22:48:46 bcowan Exp $

DESCRIPTION="Xfce 4 extras ebuild"
LICENSE="GPL-2 BSD LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

XFCE_RDEPEND=">=xfce-extra/xfce4-showdesktop-0.4.0-r1
	>=xfce-extra/xfce4-battery-0.1.1-r1
	>=xfce-extra/xfce4-systemload-0.3.2-r1
	>=xfce-extra/xfce4-minicmd-0.1.1-r1
	>=xfce-extra/xfce4-netload-0.1.3-r1
	>=xfce-extra/xfce4-artwork-0.0.4-r1
	>=xfce-extra/xfce4-clipman-0.4.1-r1
	>=xfce-extra/xfce4-cpugraph-0.2.2-r1
	>=xfce-extra/xfce4-notes-0.9.7-r1
	>=xfce-extra/xfce4-taskbar-0.1.0-r1
	>=xfce-extra/xfce4-windowlist-0.1.0-r1"
XFCE_META=1

inherit xfce4
