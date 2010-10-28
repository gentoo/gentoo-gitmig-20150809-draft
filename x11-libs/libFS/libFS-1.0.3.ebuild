# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libFS/libFS-1.0.3.ebuild,v 1.1 2010/10/28 11:06:20 scarabeus Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org FS library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6"

RDEPEND="x11-libs/xtrans"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/fontsproto"

CONFIGURE_OPTIONS="$(use_enable ipv6)"
