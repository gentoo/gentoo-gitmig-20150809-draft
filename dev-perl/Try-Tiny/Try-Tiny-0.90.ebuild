# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Try-Tiny/Try-Tiny-0.90.ebuild,v 1.7 2011/08/13 08:24:54 xarthisius Exp $

EAPI=3

MODULE_AUTHOR=DOY
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="minimal try/catch with proper localization of $@"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~ppc-macos ~x86-solaris"
IUSE=""

SRC_TEST=do
