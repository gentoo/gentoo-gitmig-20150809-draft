# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bwwhois/bwwhois-5.0-r1.ebuild,v 1.3 2012/06/07 21:35:08 ranger Exp $

inherit perl-app

MY_P=${P/bw/}

DESCRIPTION="Perl-based whois client designed to work with the new Shared Registration System"
SRC_URI="http://whois.bw.org/dist/${MY_P}.tgz"
HOMEPAGE="http://whois.bw.org/"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_install() {
	exeinto usr/bin
	newexe whois bwwhois || die

	newman whois.1 bwwhois.1 || die

	insinto /etc/whois
	doins whois.conf tld.conf sd.conf || die

	perlinfo
	insinto "${VENDOR_LIB}"
	doins bwInclude.pm || die
}
