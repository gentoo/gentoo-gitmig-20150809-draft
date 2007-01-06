# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4util/libxfce4util-4.3.99.2.ebuild,v 1.2 2007/01/06 18:03:01 nichoj Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Libraries for Xfce 4"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug doc"

RDEPEND=">=dev-libs/glib-2
	doc? ( >=dev-util/gtk-doc-1 )"


XFCE_CONFIG="`use_enable doc gtk-doc`"
xfce44_core_package
