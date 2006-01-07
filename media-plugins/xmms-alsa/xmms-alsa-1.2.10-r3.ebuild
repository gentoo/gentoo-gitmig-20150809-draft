# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-alsa/xmms-alsa-1.2.10-r3.ebuild,v 1.2 2006/01/07 01:13:11 vapier Exp $

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=media-sound/xmms-1.2.10
	media-libs/alsa-lib"

PATCH_VER="2.3.0"

PLUGIN_PATH="Output/alsa"

M4_VER="1.1"

myconf="--enable-alsa"
inherit xmms-plugin
