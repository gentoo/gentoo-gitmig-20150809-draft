# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-SRS/Mail-SRS-0.31.ebuild,v 1.3 2006/12/10 13:17:00 yuval Exp $

inherit perl-module

S=${WORKDIR}/Mail-SRS-${PV}
DESCRIPTION="Interface to Sender Rewriting Scheme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/S/SH/SHEVEK/Mail-SRS-${PV}.tar.gz"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/S/SH/SHEVEK/Mail-SRS-${PV}.readme"

KEYWORDS="~amd64 ~x86"
LICENSE="Artistic GPL-2"
IUSE="test"
SRC_TEST="do"
SLOT="0"

DEPEND=">=dev-perl/Digest-HMAC-1.01-r1
	>=dev-perl/MLDBM-2.01
	>=virtual/perl-DB_File-1.807
	>=virtual/perl-Digest-MD5-2.33
	>=virtual/perl-Storable-2.04-r1
	test? ( >=dev-perl/Test-Pod-1.00
			>=dev-perl/Test-Pod-Coverage-0.02 )"
RDEPEND="${DEPEND}"
