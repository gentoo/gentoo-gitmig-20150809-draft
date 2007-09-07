# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-fpit/xf86-input-fpit-1.1.0-r1.ebuild,v 1.2 2007/09/07 20:25:30 wolf31o2 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Fujitsu Stylistic input driver"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"

PATCHES="${FILESDIR}/${PN}-update1.diff
	${FILESDIR}/${PN}-update2.diff
	${FILESDIR}/${PN}-update3.diff"
