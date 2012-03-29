# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-fuzzy/locale-maketext-fuzzy-0.110.0.ebuild,v 1.3 2012/03/29 15:08:13 jer Exp $

EAPI=4

MY_PN=Locale-Maketext-Fuzzy
MODULE_AUTHOR=AUDREYT
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Maketext from already interpolated strings"

SLOT="0"
LICENSE="CC0-1.0-Universal"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST=do
