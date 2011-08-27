# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-fuzzy/locale-maketext-fuzzy-0.100.0.ebuild,v 1.1 2011/08/27 18:32:37 tove Exp $

EAPI=4

MY_PN=Locale-Maketext-Fuzzy
MODULE_AUTHOR=AUDREYT
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="Maketext from already interpolated strings"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST=do
