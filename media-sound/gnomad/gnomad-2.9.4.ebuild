# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomad/gnomad-2.9.4.ebuild,v 1.1 2009/05/11 14:01:58 ssuominen Exp $

EAPI=2
GCONF_DEBUG=no
inherit flag-o-matic gnome2

MY_P=${PN}2-${PV}

DESCRIPTION="A GNOME2 frontend for Creative Players (Zen, JukeBox, etc ...)"
HOMEPAGE="http://gnomad2.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="nls"

RDEPEND="sys-apps/hal
	dev-libs/dbus-glib
	>=x11-libs/gtk+-2.6:2
	>=media-libs/libnjb-2.2.4
	>=media-libs/libmtp-0.3
	>=media-libs/taglib-1.5
	>=media-libs/libid3tag-0.15.1b"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext
		dev-util/intltool )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	G2CONF+=" $(use_enable nls)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_configure() {
	strip-flags
	replace-flags -O3 -O2
	gnome2_src_configure
}
