# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4util/libxfce4util-4.4.0.ebuild,v 1.1 2007/01/22 02:06:34 nichoj Exp $

inherit xfce44

xfce44

DESCRIPTION="Libraries for Xfce4"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug doc"

RDEPEND=">=dev-libs/glib-2
	doc? ( >=dev-util/gtk-doc-1 )"


XFCE_CONFIG="${XFCE_CONFIG} $(use_enable doc gtk-doc)"
xfce44_core_package
