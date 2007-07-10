# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/class-returnvalue/class-returnvalue-0.52.ebuild,v 1.12 2007/07/10 23:33:33 mr_bones_ Exp $

inherit perl-module

MY_P=Class-ReturnValue-${PV}

DESCRIPTION="A return-value object that lets you treat it as as a boolean, array or object"
HOMEPAGE="http://www.cpan.org/authors/id/J/JE/JESSE/"
SRC_URI="mirror://cpan/authors/id/J/JE/JESSE/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha hppa amd64"
IUSE=""

DEPEND="dev-perl/Devel-StackTrace
	dev-perl/Test-Inline
	dev-lang/perl"

S=${WORKDIR}/${MY_P}
