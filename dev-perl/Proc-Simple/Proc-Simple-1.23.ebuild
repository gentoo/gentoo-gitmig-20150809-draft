# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-Simple/Proc-Simple-1.23.ebuild,v 1.1 2008/07/22 09:53:26 tove Exp $

MODULE_AUTHOR=MSCHILLI
inherit perl-module

DESCRIPTION="Perl Proc-Simple -  Launch and control background processes."
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
