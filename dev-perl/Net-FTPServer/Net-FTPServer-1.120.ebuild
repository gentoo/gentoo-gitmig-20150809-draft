# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-FTPServer/Net-FTPServer-1.120.ebuild,v 1.15 2006/09/04 11:45:04 yuval Exp $

inherit perl-module

DESCRIPTION="A secure, extensible and configurable Perl FTP server"
HOMEPAGE="http://search.cpan.org/~rwmj/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RW/RWMJ/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"
IUSE="postgres test"
SRC_TEST="do"

DEPEND="dev-perl/Archive-Zip
	dev-perl/Authen-PAM
		dev-perl/BSD-Resource
		dev-perl/Compress-Zlib
		virtual/perl-Digest-MD5
		virtual/perl-File-Temp
		virtual/perl-Getopt-Long
		virtual/perl-libnet
		dev-perl/File-Sync
		dev-perl/IO-stringy
		postgres? ( dev-perl/DBI )
	dev-lang/perl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:/etc:${D}/etc:" Makefile.PL
}

