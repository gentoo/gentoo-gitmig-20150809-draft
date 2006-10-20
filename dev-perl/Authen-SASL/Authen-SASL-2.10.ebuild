# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-SASL/Authen-SASL-2.10.ebuild,v 1.8 2006/10/20 18:51:17 kloeri Exp $

inherit perl-module

DESCRIPTION="A Perl SASL interface"
AUTHOR="GBARR"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/"
SRC_URI="mirror://cpan/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc ~x86"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="$CFLAGS"
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
