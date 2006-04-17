# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache/Cache-2.04.ebuild,v 1.1 2006/04/17 06:17:18 chriswhite Exp $

inherit perl-module

DESCRIPTION="the Cache interface"
SRC_URI="http://cpan.uwinnipeg.ca/cpan/authors/id/C/CL/CLEISHMAN/${P}.tar.gz"
HOMEPAGE="http://cpan.uwinnipeg.ca/dist/Cache"

RDEPEND="	>=virtual/perl-DB_File-1.72
			>=virtual/perl-File-Spec-0.8
			>=virtual/perl-Storable-1
			>=dev-perl/Digest-SHA1-2.01
			dev-perl/Heap
			>=dev-perl/IO-String-1.02
			dev-perl/TimeDate
			dev-perl/File-NFSLock"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="~x86"
IUSE=""
