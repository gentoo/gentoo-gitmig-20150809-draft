# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-FTPServer/Net-FTPServer-1.122.ebuild,v 1.3 2006/01/13 22:00:41 mcummings Exp $

inherit perl-module

DESCRIPTION="A secure, extensible and configurable Perl FTP server"
HOMEPAGE="http://search.cpan.org/~rwmj/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RW/RWMJ/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc sparc x86"
IUSE="postgres"
SRC_TEST="do"

DEPEND="dev-perl/Archive-Zip
		dev-perl/Authen-PAM
		dev-perl/BSD-Resource
		>=dev-perl/Compress-Zlib-1.14
		perl-core/Digest-MD5
		perl-core/File-Temp
		perl-core/Getopt-Long
		perl-core/libnet
		dev-perl/File-Sync
		dev-perl/IO-stringy
		postgres? ( dev-perl/DBI )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:/etc:${D}/etc:" Makefile.PL
}
