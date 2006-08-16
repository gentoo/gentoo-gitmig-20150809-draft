# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-tools/MIME-tools-5.420.ebuild,v 1.9 2006/08/16 12:13:18 yuval Exp $

inherit perl-module

DESCRIPTION="A Perl module for parsing and creating MIME entities"
SRC_URI="mirror://cpan/authors/id/D/DS/DSKOLL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/MIME-tools/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 hppa ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/IO-stringy-2.108
	>=virtual/perl-MIME-Base64-3.05
	virtual/perl-libnet
	dev-perl/URI
	virtual/perl-Digest-MD5
	dev-perl/libwww-perl
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser
	dev-perl/MailTools
	dev-lang/perl"
RDEPEND="${DEPEND}"

