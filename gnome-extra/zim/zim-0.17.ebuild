# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zim/zim-0.17.ebuild,v 1.1 2007/02/27 16:03:29 steev Exp $

inherit perl-module

MY_P=Zim-${PV}
S="${WORKDIR}"/${MY_P}

DESCRIPTION="A desktop wiki"
HOMEPAGE="http://pardus-larus.student.utwente.nl/~pardus/projects/zim/"
SRC_URI="http://pardus-larus.student.utwente.nl/~pardus/downloads/Zim/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome spell"

DEPEND=">=dev-lang/perl-5.8.0
	>=x11-libs/gtk+-2.4.0
	virtual/perl-Storable
	virtual/perl-File-Spec
	dev-perl/File-BaseDir
	dev-perl/File-MimeInfo
	dev-perl/File-DesktopEntry
	dev-perl/gtk2-perl
	gnome? ( dev-perl/gtk2-trayicon )
	spell? ( dev-perl/gtk2-spell )"
