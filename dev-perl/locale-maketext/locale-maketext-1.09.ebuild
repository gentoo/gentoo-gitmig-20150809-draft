# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext/locale-maketext-1.09.ebuild,v 1.5 2005/04/03 01:51:11 mcummings Exp $

inherit perl-module

MY_P=Locale-Maketext-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Localization framework for Perl programs"
HOMEPAGE="http://www.cpan.org/modules/by-module/Locale/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/S/SB/SBURKE/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa ~amd64"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/i18n-langtags-0.30"
