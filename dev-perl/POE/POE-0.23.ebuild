# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE/POE-0.23.ebuild,v 1.15 2006/02/13 13:52:06 mcummings Exp $

IUSE="gtk tcltk libwww ncurses"

inherit perl-module

DESCRIPTION="A framework for creating multitasking programs in Perl"
HOMEPAGE="http://poe.perl.org"
SRC_URI="mirror://sourceforge/poe/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	dev-perl/Event
	virtual/perl-Time-HiRes
	dev-perl/Compress-Zlib
	virtual/perl-Storable
	dev-perl/IO-Tty
	perl-core/Filter
	dev-perl/FreezeThaw
	tcltk? ( dev-perl/perl-tk )
	gtk? ( dev-perl/gtk-perl )
	libwww? ( dev-perl/libwww-perl )
	ncurses? ( dev-perl/Curses )"

mymake="/usr"

src_compile() {
	echo "n" | perl-module_src_compile
}
