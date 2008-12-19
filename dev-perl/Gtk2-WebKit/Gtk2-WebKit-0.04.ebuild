# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-WebKit/Gtk2-WebKit-0.04.ebuild,v 1.1 2008/12/19 14:51:18 tove Exp $

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Web content engine library for Gtk2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/gtk2-perl
	net-libs/webkit-gtk"
DEPEND="${RDEPEND}
	dev-perl/glib-perl
	dev-perl/extutils-pkgconfig
	dev-perl/extutils-depends"

#SRC_TEST=do
