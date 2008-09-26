# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xbacklight/xbacklight-1.1.ebuild,v 1.8 2008/09/26 12:43:34 jer Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Sets backlight level using the RandR 1.2 BACKLIGHT output property"
KEYWORDS="amd64 ~hppa ~ppc ~sparc x86 ~x86-fbsd"
RDEPEND=">=x11-libs/libXrandr-1.2"
DEPEND="${RDEPEND}"
