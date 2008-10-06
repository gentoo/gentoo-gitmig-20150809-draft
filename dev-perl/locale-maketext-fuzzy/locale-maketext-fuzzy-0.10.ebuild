# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-fuzzy/locale-maketext-fuzzy-0.10.ebuild,v 1.1 2008/10/06 11:19:23 tove Exp $

MODULE_AUTHOR=AUDREYT
MY_PN=Locale-Maketext-Fuzzy
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Maketext from already interpolated strings"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST=do
