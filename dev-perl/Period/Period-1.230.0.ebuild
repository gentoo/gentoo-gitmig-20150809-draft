# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Period/Period-1.230.0.ebuild,v 1.2 2012/02/03 16:47:46 ago Exp $

EAPI=3

MY_PN=Time-Period
MODULE_AUTHOR=PBOYD
MODULE_VERSION=1.23
inherit perl-module

DESCRIPTION="Time period Perl module"

SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST=do
