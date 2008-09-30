# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Crontab/Config-Crontab-1.21.ebuild,v 1.1 2008/09/30 06:33:49 tove Exp $

MODULE_AUTHOR=SCOTTW
inherit perl-module

DESCRIPTION="Read/Write Vixie compatible crontab(5) files"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
