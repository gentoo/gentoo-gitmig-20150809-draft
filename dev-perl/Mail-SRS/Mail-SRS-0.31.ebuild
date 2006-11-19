# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-SRS/Mail-SRS-0.31.ebuild,v 1.2 2006/11/19 08:44:51 ian Exp $

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
	>=perl-core/DB_File-1.807
	>=perl-core/Digest-MD5-2.33
	>=perl-core/Storable-2.04-r1
	test? ( >=dev-perl/Test-Pod-1.00
			>=dev-perl/Test-Pod-Coverage-0.02 )"
RDEPEND="${DEPEND}"
