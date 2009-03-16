# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Ace/Ace-1.92.ebuild,v 1.1 2009/03/16 01:50:20 weaver Exp $

inherit perl-module

DESCRIPTION="Object-Oriented Access to ACEDB Databases"
HOMEPAGE="http://search.cpan.org/~lds/AcePerl-1.92/Ace.pm"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/AcePerl-${PV}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
SRC_TEST="do"

S="${WORKDIR}/AcePerl-${PV}"

DEPEND="dev-lang/perl
	virtual/perl-Digest-MD5
	dev-perl/Cache-Cache"
