# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libwww-perl/libwww-perl-5.805.ebuild,v 1.10 2006/10/20 20:25:27 kloeri Exp $

inherit perl-module

DESCRIPTION="A collection of Perl Modules for the WWW"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"
IUSE="ssl"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"

DEPEND="virtual/perl-libnet
	>=dev-perl/HTML-Parser-3.34
	>=dev-perl/URI-1.10
	>=virtual/perl-Digest-MD5-2.12
	dev-perl/HTML-Tree
	>=virtual/perl-MIME-Base64-2.12
	>=dev-perl/Compress-Zlib-1.10
	ssl? ( dev-perl/Crypt-SSLeay )
	dev-lang/perl"

src_compile() {
	echo "y" | perl-module_src_compile
}

src_install() {
	perl-module_src_install
	dosym /usr/bin/lwp-request /usr/bin/GET
	dosym /usr/bin/lwp-request /usr/bin/POST
	dosym /usr/bin/lwp-request /usr/bin/HEAD
}


