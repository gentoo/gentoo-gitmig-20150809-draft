# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-rhythmbox/pidgin-rhythmbox-2.0.ebuild,v 1.6 2007/08/28 14:52:42 nixnut Exp $

DESCRIPTION="automatically update your pidgin profile with current info from Rhythmbox"
HOMEPAGE="http://jon.oberheide.org/projects/pidgin-rhythmbox"
SRC_URI="http://jon.oberheide.org/projects/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="net-im/pidgin
	>=media-sound/rhythmbox-0.9
	>=x11-libs/gtk+-2.4
	>=sys-apps/dbus-0.50
	>=dev-libs/dbus-glib-0.50"
S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	#sed -i -e 's:--variable=prefix`/lib:--variable=libdir`:' \
	#	${S}/configure{.ac,} || die "sed failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
