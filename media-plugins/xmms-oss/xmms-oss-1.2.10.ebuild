# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-oss/xmms-oss-1.2.10.ebuild,v 1.1 2005/02/12 03:06:29 eradicator Exp $

IUSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=media-sound/xmms-1.2.10"

PLUGIN_PATH="Output/OSS"

M4_VER="1.0"

inherit xmms-plugin

src_compile() {
	if [ -e /dev/sound ]; then
		myconf="--with-dev-dsp=/dev/sound/dsp \
		        --with-dev-mixer=/dev/sound/mixer"
	fi

	myconf="${myconf} --enable-oss"
	xmms-plugin_src_compile
}
