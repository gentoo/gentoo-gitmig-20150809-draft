# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-mcs-plugins/xfce-mcs-plugins-4.2.0.ebuild,v 1.1 2005/01/17 01:56:22 bcowan Exp $

DESCRIPTION="Xfce4 mcs plugins"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

BZIPPED=1
XFCE_CONFIG="--enable-xf86misc --enable-xkb --enable-randr --enable-xf86vm"

inherit xfce4
