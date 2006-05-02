# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bwwhois/bwwhois-3.4.ebuild,v 1.11 2006/05/02 02:54:00 weeve Exp $

inherit perl-app

MY_P=${P/bw/}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl-based whois client designed to work with the new Shared Registration System"
SRC_URI="http://whois.bw.org/dist/${MY_P}.tgz"
HOMEPAGE="http://whois.bw.org/"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	einfo "no compilation necessary"
}

src_install () {
	exeinto usr/bin
	newexe whois bwwhois

	mv whois.1 bwwhois.1
	doman bwwhois.1

	insinto etc/whois
	doins whois.conf tld.conf sd.conf

	perlinfo
	insinto ${SITE_LIB}
	doins bwInclude.pm
	updatepod
}
