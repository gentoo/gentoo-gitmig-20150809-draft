# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-esd/xmms-esd-1.2.10-r1.ebuild,v 1.1 2005/02/12 03:07:47 eradicator Exp $

IUSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=media-sound/xmms-1.2.10
	>=media-sound/esound-0.2.22"

PATCH_VER="2.2.2"

PLUGIN_PATH="Output/esd"

M4_VER="1.0"

myconf="--enable-esd"
inherit xmms-plugin
