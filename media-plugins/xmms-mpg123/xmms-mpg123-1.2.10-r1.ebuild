# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mpg123/xmms-mpg123-1.2.10-r1.ebuild,v 1.1 2005/02/12 02:22:25 eradicator Exp $

IUSE="ipv6 ssl"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=media-sound/xmms-1.2.10-r12
	ssl? ( dev-libs/openssl )"

PATCH_VER="2.2.2"

PLUGIN_PATH="Input/mpg123"

myconf="--enable-mpg123 `use_enable ipv6` `use_enable ssl`"
M4_VER="1.0"

inherit xmms-plugin
