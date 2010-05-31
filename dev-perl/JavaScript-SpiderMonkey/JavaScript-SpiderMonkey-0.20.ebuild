# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JavaScript-SpiderMonkey/JavaScript-SpiderMonkey-0.20.ebuild,v 1.1 2010/05/31 08:16:42 tove Exp $

EAPI=3

MODULE_AUTHOR="TBUSCH"
inherit perl-module

DESCRIPTION="Perl interface to the JavaScript Engine"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-perl/Log-Log4perl
	>=dev-lang/spidermonkey-1.5"
DEPEND="${RDEPEND}"

SRC_TEST=do
