# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-SASL/Authen-SASL-2.04.ebuild,v 1.6 2004/01/07 18:12:17 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Perl SASL interface"
AUTHOR="GBARR"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~sparc alpha ppc ia64"

export OPTIMIZE="$CFLAGS"
