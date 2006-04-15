# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xffm/xffm-4.2.3.ebuild,v 1.4 2006/04/15 01:59:01 halcy0n Exp $

inherit xfce42

DESCRIPTION="Xfce 4 file manager"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE="samba"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM )
	virtual/x11 )
	~xfce-base/xfce-mcs-manager-${PV}
	samba? ( net-fs/samba )"
DEPEND="${RDEPEND}
	|| ( ( x11-libs/libXt
	x11-proto/xproto )
	virtual/x11 )"

XFCE_CONFIG="--enable-all"
core_package
