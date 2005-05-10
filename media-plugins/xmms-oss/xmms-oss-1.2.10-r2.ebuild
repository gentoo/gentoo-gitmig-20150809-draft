# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-oss/xmms-oss-1.2.10-r2.ebuild,v 1.1 2005/05/10 18:38:08 eradicator Exp $

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=media-sound/xmms-1.2.10"

PATCH_VER="2.2.6"

PLUGIN_PATH="Output/OSS"

M4_VER="1.1"

myconf="--enable-oss"
inherit xmms-plugin
