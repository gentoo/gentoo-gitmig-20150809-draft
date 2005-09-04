# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gksu/gksu-1.3.4.ebuild,v 1.1 2005/09/04 05:56:59 dragonheart Exp $

inherit gnome2

DESCRIPTION="A gtk+ frontend for libgksu"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/gksu/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="${IUSE} nls"

RDEPEND=">=x11-libs/libgksu-1.3.3
	>=x11-libs/libgksuui-1.0.6
	>=x11-libs/gtk+-2.4.0
	>=gnome-base/gconf-2.0
	gnome-base/gnome-keyring
	app-admin/sudo
	virtual/x11
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/sed
	sys-devel/bison
	sys-apps/grep"


GCONF2="$(use_enable nls)"
USE_DESTDIR="1"
