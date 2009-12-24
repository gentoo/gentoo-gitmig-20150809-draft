# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-rhythmbox/pidgin-rhythmbox-2.0.ebuild,v 1.10 2009/12/24 08:10:57 pva Exp $

EAPI=2

DESCRIPTION="automatically update your pidgin profile with current info from Rhythmbox"
HOMEPAGE="http://jon.oberheide.org/pidgin-rhythmbox/"
SRC_URI="http://jon.oberheide.org/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="net-im/pidgin
	media-sound/rhythmbox
	>=x11-libs/gtk+-2.4:2
	dev-libs/dbus-glib"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
