# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-hotkeys/pidgin-hotkeys-0.2.4.ebuild,v 1.5 2010/10/26 14:31:29 jer Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Pidgin plugin to define global hotkeys for various actions"
HOMEPAGE="http://pidgin-hotkeys.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE=""

RDEPEND="net-im/pidgin[gtk]
	>=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README NEWS || die
}
