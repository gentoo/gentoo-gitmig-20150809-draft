# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-Das/Bio-Das-1.14.ebuild,v 1.1 2009/09/05 11:13:21 tove Exp $

EAPI=2

MODULE_AUTHOR="LDS"
inherit perl-module

DESCRIPTION="Interface to Distributed Annotation System"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/perl-IO-Compress-1.0
	sci-biology/bioperl
	>=dev-perl/HTML-Parser-3
	>=dev-perl/libwww-perl-5
	>=virtual/perl-MIME-Base64-2.12"
RDEPEND="${DEPEND}"

# Tests work again as of 1.10 (were broken in 1.09)
SRC_TEST="do"
