# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-vorbis/xmms-vorbis-1.2.10-r1.ebuild,v 1.1 2005/02/12 01:28:51 eradicator Exp $

IUSE="ipv6 ssl"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=media-sound/xmms-1.2.10
	media-libs/libvorbis
	ssl? ( dev-libs/openssl )"

PATCH_VER="2.2.1"
GENTOO_URI="http://dev.gentoo.org/~eradicator/xmms"
PLUGIN_PATH="Input/vorbis"

myconf="--enable-vorbis `use_enable ipv6` `use_enable ssl`"

inherit xmms-plugin
