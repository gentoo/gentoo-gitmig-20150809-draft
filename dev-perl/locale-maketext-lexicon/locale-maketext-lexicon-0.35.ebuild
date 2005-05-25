# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-lexicon/locale-maketext-lexicon-0.35.ebuild,v 1.9 2005/05/25 15:17:34 mcummings Exp $

inherit perl-module

MY_P=Locale-Maketext-Lexicon-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Use other catalog formats in Maketext"
HOMEPAGE="http://www.cpan.org/authors/id/A/AU/AUTRIJUS/"
SRC_URI="http://www.cpan.org/authors/id/A/AU/AUTRIJUS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha hppa amd64"
IUSE=""

DEPEND="dev-perl/locale-maketext
		<perl-core/Test-Simple-0.48
	dev-perl/regexp-common"

SRC_TEST="do"
