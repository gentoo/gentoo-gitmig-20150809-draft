# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.2.0.ebuild,v 1.6 2005/02/01 17:41:21 bcowan Exp $

DESCRIPTION="Xfce 4 utilities"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 sparc x86"
IUSE="gtkhtml"

BZIPPED=1
RDEPEND="~xfce-base/xfce-mcs-manager-${PV}
	gtkhtml? ( gnome-extra/libgtkhtml )"
XFCE_CONFIG="$(use_enable gtkhtml) --enable-gdm"

inherit xfce4
