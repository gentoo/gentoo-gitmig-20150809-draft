# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Ace/Ace-1.92.ebuild,v 1.2 2009/05/12 21:00:08 tove Exp $

EAPI=2

MODULE_AUTHOR=LDS
MY_PN=AcePerl
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Object-Oriented Access to ACEDB Databases"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="virtual/perl-Digest-MD5
	dev-perl/Cache-Cache"
RDEPEND="${DEPEND}"

# online tests
RESTRICT=test
