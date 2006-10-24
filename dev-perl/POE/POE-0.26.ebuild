# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE/POE-0.26.ebuild,v 1.17 2006/10/24 21:57:21 mcummings Exp $

IUSE="gtk ipv6 libwww ncurses tk"

inherit perl-module

DESCRIPTION="A framework for creating multitasking programs in Perl"
HOMEPAGE="http://poe.perl.org"
SRC_URI="mirror://sourceforge/poe/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="alpha amd64 ppc sparc x86"

DEPEND="dev-perl/ExtUtils-AutoInstall
	dev-perl/Event
	virtual/perl-Time-HiRes
	dev-perl/Compress-Zlib
	virtual/perl-Storable
	dev-perl/IO-Tty
	perl-core/Filter
	dev-perl/FreezeThaw
	ipv6? ( dev-perl/Socket6 )
	tk? ( dev-perl/perl-tk )
	gtk? ( dev-perl/gtk-perl )
	libwww? ( dev-perl/libwww-perl )
	ncurses? ( dev-perl/Curses )
	dev-lang/perl"
RDEPEND="${DEPEND}"

mymake="/usr"

src_compile() {
	echo "n" | perl-module_src_compile
}


