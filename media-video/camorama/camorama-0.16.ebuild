# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camorama/camorama-0.16.ebuild,v 1.1 2003/04/13 17:56:13 liquidx Exp $

inherit gnome2

IUSE=""
DESCRIPTION="A GNOME 2 Webcam application featuring various image filters."
HOMEPAGE="http://camorama.fixedgear.org/"
SRC_URI="http://camorama.fixedgear.org/downloads/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
DEPEND=">=x11-libs/gtk+-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/gconf-2.0
	>=gnome-base/libglade-2.0
	>=sys-devel/gettext-0.11
	>=dev-util/intltool-0.20"
	
S=${WORKDIR}/${P}

SCROLLKEEPER_UPDATE="0"
