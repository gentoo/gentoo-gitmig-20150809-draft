# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/liteamp/liteamp-0.2.2-r1.ebuild,v 1.1 2003/07/17 21:31:54 raker Exp $

inherit eutils gnome2

S="${WORKDIR}/${P}"
DESCRIPTION="Liteamp - yet another light-weight ogg and mp3 player for gnome"
SRC_URI="http://download.kldp.net/liteamp/${P}.tar.gz"
HOMEPAGE="http://liteamp.kldp.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=gnome-base/libgnomeui-2.0
	>=media-libs/libmad-0.15.0b
	>=media-libs/libid3tag-0.15.0b
	>=media-libs/libvorbis-1.0
	media-libs/libao
	media-libs/libogg"

DOC="AUTHORS COPYING ChangeLog  INSTALL NEWS README"
