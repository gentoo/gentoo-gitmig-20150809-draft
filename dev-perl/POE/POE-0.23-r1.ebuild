# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE/POE-0.23-r1.ebuild,v 1.4 2003/02/13 11:17:05 vapier Exp $

IUSE="gtk tcltk libwww curses"

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A framework for creating multitasking programs in Perl"
HOMEPAGE="http://poe.perl.org"
SRC_URI="mirror://sourceforge/poe/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}
	dev-perl/Event
	dev-perl/Time-HiRes
	dev-perl/Compress-Zlib
	dev-perl/Storable
	dev-perl/IO-Tty
	dev-perl/Filter
	dev-perl/FreezeThaw
	tcltk? ( dev-perl/perl-tk )
	gtk? ( dev-perl/gtk-perl )
	libwww? ( dev-perl/libwww-perl )
	curses? ( dev-perl/Curses )"

mymake="/usr"

src_compile() {

        echo "n" | perl-module_src_compile 
				}

