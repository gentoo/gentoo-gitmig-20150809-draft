# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Sexy/Gtk2-Sexy-0.05.ebuild,v 1.2 2009/11/23 21:27:40 tove Exp $

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Perl interface to the sexy widget collection"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/gtk2-perl
	x11-libs/libsexy
	dev-lang/perl"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	dev-util/pkgconfig"
