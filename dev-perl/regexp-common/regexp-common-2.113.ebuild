# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/regexp-common/regexp-common-2.113.ebuild,v 1.2 2003/12/30 17:25:27 mcummings Exp $

inherit perl-module

MY_P=Regexp-Common-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Provide commonly requested regular expressions"
SRC_URI="http://www.cpan.org/authors/id/A/AB/ABIGAIL/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/A/AB/ABIGAIL/"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha ~hppa"

DEPEND="${DEPEND}"
