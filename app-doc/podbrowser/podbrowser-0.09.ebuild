# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/podbrowser/podbrowser-0.09.ebuild,v 1.1 2005/12/12 13:17:20 mcummings Exp $

DESCRIPTION="PodBrowser is a documentation browser for Perl."
HOMEPAGE="http://jodrell.net/projects/podbrowser"
SRC_URI="http://jodrell.net/files/podbrowser/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=x11-libs/gtk+-2.4.0
		sys-devel/gettext
		||( >=gnome-base/gnome-light-2.4.0 >=gnome-base/gnome-2.4.0 )"
RDEPEND="dev-perl/Gtk2-PodViewer
		dev-perl/gtk2-gladexml
		dev-perl/gtk2-perl
		dev-perl/Locale-gettext
		dev-perl/Pod-Simple
		dev-perl/URI
		dev-perl/Gtk2-Ex-PodViewer
		dev-perl/Gtk2-Ex-PrintDialog
		dev-perl/Gtk2-Ex-Simple-List
		>=dev-lang/perl-5.8.0"

