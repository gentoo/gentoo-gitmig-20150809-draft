# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-RPC/JSON-RPC-0.96.ebuild,v 1.3 2010/08/11 22:14:23 josejx Exp $

EAPI="2"

MODULE_AUTHOR="MAKAMAKA"

inherit perl-module

DESCRIPTION="Perl implementation of JSON-RPC 1.1 protocol"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	>=dev-perl/JSON-2.21
	dev-lang/perl"

SRC_TEST="do"
