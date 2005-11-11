# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXcursor/libXcursor-1.1.5.ebuild,v 1.1 2005/11/11 17:30:30 spyderous Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

PATCHES="${FILESDIR}/make-icondir-configurable.patch"

DESCRIPTION="X.Org Xcursor library"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~s390 ~sh ~sparc ~x86"
RDEPEND="x11-libs/libXrender
	x11-libs/libXfixes
	x11-libs/libX11
	x11-proto/xproto"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--with-icondir=/usr/share/cursors/xorg-x11
	--with-xcursor-path=~/.cursors:~/.icons:/usr/local/share/cursors/xorg-x11:/usr/share/cursors/xorg-x11:/usr/share/pixmaps/xorg-x11"
