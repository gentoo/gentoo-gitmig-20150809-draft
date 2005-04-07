# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE/POE-0.26.ebuild,v 1.9 2005/04/07 20:38:44 hansmi Exp $

IUSE="gtk ipv6 libwww ncurses tcltk"

inherit perl-module

DESCRIPTION="A framework for creating multitasking programs in Perl"
HOMEPAGE="http://poe.perl.org"
SRC_URI="mirror://sourceforge/poe/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	dev-perl/ExtUtils-AutoInstall
	dev-perl/Event
	dev-perl/Time-HiRes
	dev-perl/Compress-Zlib
	dev-perl/Storable
	dev-perl/IO-Tty
	dev-perl/Filter
	dev-perl/FreezeThaw
	ipv6? ( dev-perl/Socket6 )
	tcltk? ( dev-perl/perl-tk )
	gtk? ( dev-perl/gtk-perl )
	libwww? ( dev-perl/libwww-perl )
	ncurses? ( dev-perl/Curses )"

mymake="/usr"

src_compile() {
	echo "n" | perl-module_src_compile
}
