# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXext/libXext-1.1.ebuild,v 1.2 2009/10/03 15:18:55 scarabeus Exp $

inherit x-modular

DESCRIPTION="X.Org Xext library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libX11-1.2"
DEPEND="${RDEPEND}
	>=x11-proto/xextproto-7.1
	>=x11-proto/xproto-7.0.16"
