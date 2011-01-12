# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Try-Tiny/Try-Tiny-0.90.ebuild,v 1.1 2011/01/12 15:55:56 tove Exp $

EAPI=3

MODULE_AUTHOR=DOY
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="minimal try/catch with proper localization of $@"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

SRC_TEST=do
