# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Curl/WWW-Curl-4.05.ebuild,v 1.2 2009/01/17 22:27:22 robbat2 Exp $

MODULE_AUTHOR="SZBALINT"
inherit perl-module

DESCRIPTION="Perl extension interface for libcurl"

IUSE=""

RDEPEND="net-misc/curl
		 dev-lang/perl"
DEPEND="${RDEPEND}"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"
SRC_TEST="do"
