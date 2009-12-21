# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-hotkeys/pidgin-hotkeys-0.2.3.ebuild,v 1.12 2009/12/21 13:01:10 vapier Exp $

EAPI="2"

inherit eutils

DESCRIPTION="plugin that allows you to define global hotkeys for various actions"
HOMEPAGE="http://gaim-hotkeys.sourceforge.net/"
SRC_URI="mirror://sourceforge/gaim-hotkeys/${P}.tar.gz"

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
}
