# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bwwhois/bwwhois-3.2.ebuild,v 1.2 2003/02/13 14:46:15 vapier Exp $

inherit perl-post

P=whois-3.2
S=${WORKDIR}/${P}
A=${P}.tgz
DESCRIPTION="Perl-based whois client designed to work with the new Shared Registration System"
SRC_URI="http://whois.bw.org/dist/${A}"
HOMEPAGE="http://whois.bw.org/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="sys-devel/perl"

src_unpack() {

	unpack ${A}
	cd ${S}
}

src_install () {

	exeinto usr/bin
	newexe whois bwwhois
	dosym bwwhois /usr/bin/whois

	doman whois.1

	insinto etc/whois
	doins whois.conf tld.conf sd.conf

	perl-post_perlinfo
	insinto ${SITE_LIB}
	doins bwInclude.pm
	perl-post_updatepod
}
