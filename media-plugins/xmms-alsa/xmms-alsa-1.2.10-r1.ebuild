# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-alsa/xmms-alsa-1.2.10-r1.ebuild,v 1.1 2005/02/12 03:04:30 eradicator Exp $

IUSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=media-sound/xmms-1.2.10
	>=media-libs/alsa-lib-0.9.0"

PATCH_VER="2.2.2"

PLUGIN_PATH="Output/alsa"

M4_VER="1.0"

myconf="--enable-alsa"
inherit xmms-plugin
