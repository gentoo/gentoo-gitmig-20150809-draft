# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE/POE-0.38.ebuild,v 1.8 2007/07/10 23:33:28 mr_bones_ Exp $

IUSE="ipv6 libwww ncurses tk"

inherit versionator perl-module
MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A framework for creating multitasking programs in Perl"
HOMEPAGE="http://search.cpan.org/~rcaputo/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/R/RC/RCAPUTO/${MY_P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64 ppc sparc ~x86"

DEPEND="dev-perl/ExtUtils-AutoInstall
	>=dev-perl/Event-1.00
	>=virtual/perl-Time-HiRes-1.59
	>=dev-perl/Compress-Zlib-1.33
	>=virtual/perl-Storable-2.12
	>=dev-perl/IO-Tty-1.02
	perl-core/Filter
	>=virtual/perl-File-Spec-0.87
	>=virtual/perl-Test-Harness-2.26
	dev-perl/FreezeThaw
	>=virtual/perl-Test-Simple-0.54
	>=dev-perl/TermReadKey-2.21
	ipv6? ( >=dev-perl/Socket6-0.14 )
	tk? ( >=dev-perl/perl-tk-800.027 )
	libwww? ( >=dev-perl/libwww-perl-5.79
		>=dev-perl/URI-1.30 )
	ncurses? ( >=dev-perl/Curses-1.08 )
	dev-lang/perl"

mymake="/usr"

src_compile() {
	echo "n" | perl-module_src_compile
}
