# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xffm/xffm-4.2.0.ebuild,v 1.5 2005/01/31 15:32:21 lanius Exp $

DESCRIPTION="Xfce 4 file manager"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 sparc x86"

BZIPPED=1
XRDEPEND="samba? ( net-fs/samba )"
XFCE_CONFIG="--enable-all"

inherit xfce4