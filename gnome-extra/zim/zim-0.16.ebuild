# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zim/zim-0.16.ebuild,v 1.1 2006/09/10 14:38:06 steev Exp $

inherit perl-module

MY_P=Zim-${PV}
S="${WORKDIR}"/${MY_P}

DESCRIPTION="A desktop wiki"
HOMEPAGE="http://zoidberg.student.utwente.nl/zim/index.shtml"
SRC_URI="http://zoidberg.student.utwente.nl/downloads/Zim/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome spell"

DEPEND=">=dev-lang/perl-5.8.0
	>=x11-libs/gtk+-2.4.0
	perl-core/Storable
	perl-core/File-Spec
	dev-perl/File-BaseDir
	dev-perl/File-MimeInfo
	dev-perl/File-DesktopEntry
	dev-perl/gtk2-perl
	gnome? ( dev-perl/gtk2-trayicon )
	spell? ( dev-perl/gtk2-spell )"
