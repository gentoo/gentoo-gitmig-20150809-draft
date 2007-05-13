# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perlbal/Perlbal-1.57.ebuild,v 1.2 2007/05/13 08:33:47 robbat2 Exp $

inherit perl-module

DESCRIPTION="Reverse-proxy load balancer and webserver"
HOMEPAGE="http://www.danga.com/perlbal/"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/libwww-perl
		>=dev-perl/Danga-Socket-1.57
		dev-perl/Sys-Syscall
		dev-perl/BSD-Resource
		dev-lang/perl"
#SRC_TEST="do" # testing not available on Perlbal yet ;-)
mydoc="CHANGES"

src_install() {
	perl-module_src_install || die "perl-module_src_install failed"
	cd ${S}
	dodoc doc/*.txt
	docinto hacking
	dodoc doc/hacking/*.txt
	docinto conf
	dodoc conf/*.{dat,conf}
	keepdir /etc/perlbal
}
