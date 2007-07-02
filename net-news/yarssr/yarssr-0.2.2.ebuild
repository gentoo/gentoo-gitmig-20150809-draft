# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/yarssr/yarssr-0.2.2.ebuild,v 1.2 2007/07/02 15:07:03 peper Exp $

inherit eutils

DESCRIPTION="Yet Another RSS Reader - A KDE/Gnome system tray rss aggregator"
HOMEPAGE="http://yarssr.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="dev-perl/Locale-gettext
	dev-perl/XML-RSS
	dev-perl/gtk2-trayicon
	dev-perl/gtk2-gladexml
	dev-perl/gnome2-vfs-perl
	>=dev-perl/gnome2-perl-0.94"
DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install died"
	dodoc ChangeLog TODO README
}
