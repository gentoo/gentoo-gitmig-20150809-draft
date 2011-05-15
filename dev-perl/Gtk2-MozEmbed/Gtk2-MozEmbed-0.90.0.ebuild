# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-MozEmbed/Gtk2-MozEmbed-0.90.0.ebuild,v 1.1 2011/05/15 14:46:35 tove Exp $

EAPI=4

MODULE_AUTHOR=TSCH
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="Interface to the Mozilla embedding widget"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-perl/gtk2-perl-1.144
	net-libs/xulrunner"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.205
	>=dev-perl/extutils-pkgconfig-1.07"
