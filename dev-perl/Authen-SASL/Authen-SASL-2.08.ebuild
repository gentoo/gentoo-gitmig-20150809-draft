# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-SASL/Authen-SASL-2.08.ebuild,v 1.1 2004/07/30 16:25:36 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl SASL interface"
AUTHOR="GBARR"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~amd64 ~ia64 ~s390 ~hppa"
IUSE=""

export OPTIMIZE="$CFLAGS"
