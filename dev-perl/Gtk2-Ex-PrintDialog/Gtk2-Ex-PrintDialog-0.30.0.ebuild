# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Ex-PrintDialog/Gtk2-Ex-PrintDialog-0.30.0.ebuild,v 1.2 2011/09/03 21:05:24 tove Exp $

EAPI=4

MODULE_AUTHOR=GBROWN
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="a simple, pure Perl dialog for printing PostScript data in GTK+ applications"

SLOT="0"
KEYWORDS="amd64 ia64 x86"
IUSE="cups"

RDEPEND="cups? ( dev-perl/Net-CUPS )
	dev-perl/gtk2-perl
	>=dev-perl/Locale-gettext-1.04"
DEPEND="${RDEPEND}"

#SRC_TEST="do"
