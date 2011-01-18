# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-Daemon/Proc-Daemon-0.60.ebuild,v 1.1 2011/01/18 07:14:49 tove Exp $

EAPI=3

MODULE_AUTHOR=DETI
MODULE_SECTION=Proc
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Perl Proc-Daemon -  Run Perl program as a daemon process"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"
