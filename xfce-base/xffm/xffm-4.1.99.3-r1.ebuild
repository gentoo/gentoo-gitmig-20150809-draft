# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xffm/xffm-4.1.99.3-r1.ebuild,v 1.2 2005/01/10 17:56:29 bcowan Exp $

DESCRIPTION="Xfce 4 file manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

XRDEPEND="samba? ( net-fs/samba )"
XFCE_CONFIG="--enable-all"

inherit xfce4