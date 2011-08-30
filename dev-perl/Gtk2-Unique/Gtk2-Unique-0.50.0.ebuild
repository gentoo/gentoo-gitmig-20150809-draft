# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Unique/Gtk2-Unique-0.50.0.ebuild,v 1.4 2011/08/30 14:53:45 tove Exp $

EAPI=4

MODULE_AUTHOR=POTYL
MODULE_VERSION=0.05
inherit eutils perl-module

DESCRIPTION="Perl binding for C libunique library"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/libunique:1
	dev-perl/gtk2-perl
"
DEPEND="${RDEPEND}
	dev-perl/glib-perl
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
"

PATCHES=( "${FILESDIR}"/${PN}-0.05-implicit-pointer.patch )
