# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP-Lite/SOAP-Lite-0.66.ebuild,v 1.9 2006/10/20 19:56:38 kloeri Exp $

IUSE="jabber ssl"

inherit perl-module eutils

MY_PV=${PV/a//}
MY_P=SOAP-Lite-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Provides a simple and lightweight interface to the SOAP protocol (sic) both on client and server side."

SRC_URI="mirror://cpan/authors/id/B/BY/BYRNE/SOAP/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~byrne/${P}"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc sparc ~x86"

myconf="${myconf} --noprompt"

# TESTS ARE DISABLED ON PURPOSE
# This module attempts to access an external website for validation
# of the MIME::Parser - not only is that bad practice in general,
# but in this particular case the external site isn't even valid anymore# -mpc
# 24/10/04
#SRC_TEST="do"

DEPEND="dev-perl/XML-Parser
	dev-perl/libwww-perl
	virtual/perl-libnet
	dev-perl/MIME-Lite
	virtual/perl-MIME-Base64
	ssl? ( dev-perl/Crypt-SSLeay )
	jabber? ( dev-perl/Net-Jabber )
	ssl? ( dev-perl/IO-Socket-SSL )
	dev-perl/Compress-Zlib
	>=dev-perl/MIME-tools-5.413
	dev-lang/perl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	# The author of this module put a dep for MIME::Parser 6.X - but the6.X
	# release of MIME::Parser was a mistake during a change in maintainers on
	# cpan. This patch alters the dependancy to the "real" stable version of
	# MIME::Parser.
	epatch ${FILESDIR}/SOAP-Lite-0.60.a.patch
}

