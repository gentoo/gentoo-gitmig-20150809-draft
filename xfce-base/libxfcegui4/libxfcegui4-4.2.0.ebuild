# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfcegui4/libxfcegui4-4.2.0.ebuild,v 1.1 2005/01/17 01:53:42 bcowan Exp $

DESCRIPTION="Libraries for Xfce 4"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="xinerama"

BZIPPED=1
XRDEPEND=">=xfce-base/libxfce4util-${PV}"
XFCE_CONFIG="$(use_enable xinerama)"

inherit xfce4