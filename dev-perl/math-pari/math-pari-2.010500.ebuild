# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/math-pari/math-pari-2.010500.ebuild,v 1.3 2003/06/24 10:29:36 mcummings Exp $

inherit perl-module

MY_P="Math-Pari-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to PARI"
PARI_VERSION=`best_version app-sci/pari`
SRC_URI="http://www.cpan.org/authors/id/I/IL/ILYAZ/modules/${MY_P}.tar.gz
		http://www.gn-50uma.de/ftp/pari-2.1/pari-${PARI_VERSION}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/I/IL/ILYAZ/modules/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~ppc ~sparc"

DEPEND="app-sci/pari"

