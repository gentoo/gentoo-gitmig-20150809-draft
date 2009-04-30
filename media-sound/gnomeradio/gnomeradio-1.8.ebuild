# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomeradio/gnomeradio-1.8.ebuild,v 1.1 2009/04/30 17:48:25 ssuominen Exp $

GCONF_DEBUG=no
inherit gnome2

DESCRIPTION="A GNOME2 radio tuner"
HOMEPAGE="http://www.wh-hms.uni-ulm.de/~mfcn/gnomeradio"
SRC_URI="http://www.wh-hms.uni-ulm.de/~mfcn/${PN}/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="lirc"

RDEPEND=">=gnome-extra/gnome-media-2.14
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/gconf-2.12
	>=gnome-base/gnome-vfs-2.12
	=media-libs/gst-plugins-base-0.10*
	lirc? ( app-misc/lirc )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	app-text/scrollkeeper"

DOCS="AUTHORS ChangeLog NEWS README* TODO"
