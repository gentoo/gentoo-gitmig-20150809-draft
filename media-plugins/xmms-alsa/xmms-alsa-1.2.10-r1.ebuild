# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-alsa/xmms-alsa-1.2.10-r1.ebuild,v 1.3 2005/03/19 18:09:21 vapier Exp $

SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=media-sound/xmms-1.2.10
	>=media-libs/alsa-lib-0.9.0"

PATCH_VER="2.2.2"

PLUGIN_PATH="Output/alsa"

M4_VER="1.1"

myconf="--enable-alsa"
inherit xmms-plugin
