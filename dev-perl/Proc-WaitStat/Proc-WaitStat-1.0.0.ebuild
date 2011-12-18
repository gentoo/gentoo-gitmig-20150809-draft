# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-WaitStat/Proc-WaitStat-1.0.0.ebuild,v 1.3 2011/12/18 17:43:10 armin76 Exp $

EAPI=4

MODULE_AUTHOR=ROSCH
MODULE_VERSION=1.00
inherit perl-module

DESCRIPTION="Interpret and act on wait() status values"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="dev-perl/IPC-Signal"
DEPEND="${RDEPEND}"

SRC_TEST="do"
