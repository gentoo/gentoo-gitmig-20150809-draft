# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SSLeay/Net-SSLeay-1.15.ebuild,v 1.4 2002/07/25 04:13:27 seemant Exp $


inherit perl-module

S=${WORKDIR}/Net_SSLeay.pm-${PV}
DESCRIPTION="Net::SSLeay module for perl"
SRC_URI="http://www.cpan.org/authors/id/SAMPO/Net_SSLeay.pm-${PV}.tar.gz"
SLOT="0"

SLOT="0"
DEPEND="${DEPEND} dev-libs/openssl"
LICENSE="Artistic | GPL-2"
SLOT="0"

export OPTIMIZE="$CFLAGS"
