# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bwwhois/bwwhois-3.2.ebuild,v 1.4 2003/05/30 13:13:40 seemant Exp $

inherit perl-module

MY_P=${P/bw/}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl-based whois client designed to work with the new Shared Registration System"
SRC_URI="http://whois.bw.org/dist/${MY_P}.tgz"
HOMEPAGE="http://whois.bw.org/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

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
	dosym bwwhois /usr/bin/whois

	doman whois.1

	insinto etc/whois
	doins whois.conf tld.conf sd.conf

	perlinfo
	insinto ${SITE_LIB}
	doins bwInclude.pm
	updatepod
}
