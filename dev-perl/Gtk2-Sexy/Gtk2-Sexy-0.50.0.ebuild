# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Sexy/Gtk2-Sexy-0.50.0.ebuild,v 1.1 2011/08/30 14:54:52 tove Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="Perl interface to the sexy widget collection"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/gtk2-perl
	x11-libs/libsexy"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	dev-util/pkgconfig"
