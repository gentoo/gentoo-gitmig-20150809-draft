# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/class-returnvalue/class-returnvalue-0.51.ebuild,v 1.2 2003/12/30 13:04:04 mcummings Exp $

inherit perl-module

MY_P=Class-ReturnValue-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A return-value object that lets you treat it as as a boolean, array or object"
SRC_URI="http://www.cpan.org/authors/id/J/JE/JESSE/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/J/JE/JESSE/"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha ~hppa"
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
inherit perl-module

DEPEND="${DEPEND}
		dev-perl/Devel-StackTrace
		dev-perl/Test-Inline"
