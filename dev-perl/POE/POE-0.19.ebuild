# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE/POE-0.19.ebuild,v 1.3 2002/07/11 06:30:22 drobbins Exp $

DESCRIPTION="A framework for creating multitasking programs in Perl"
HOMEPAGE="http://poe.perl.org"

SRC_URI="http://poe.perl.org/poedown/${P}.tar.gz"
S=${WORKDIR}/${P}

DEPEND=">=sys-devel/perl-5
	dev-perl/Event
	dev-perl/Time-HiRes
	dev-perl/Compress-Zlib
	dev-perl/Storable
	dev-perl/IO-Tty
	dev-perl/Filter
	tcltk?  (dev-perl/perl-tk)
	gtk?    (dev-perl/gtk-perl)
	libwww? (dev-perl/libwww-perl)
	curses? (dev-perl/Curses)"


inherit perl-module

mymake="/usr"
