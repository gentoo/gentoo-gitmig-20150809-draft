# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.2.2.ebuild,v 1.5 2005/07/09 01:28:09 vapier Exp $

DESCRIPTION="Xfce 4 utilities"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="gtkhtml"

RDEPEND="~xfce-base/xfce-mcs-manager-${PV}
	gtkhtml? ( gnome-extra/libgtkhtml )"
XFCE_CONFIG="$(use_enable gtkhtml) --enable-gdm"

inherit xfce4
