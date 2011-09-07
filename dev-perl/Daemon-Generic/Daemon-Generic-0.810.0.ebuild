# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Daemon-Generic/Daemon-Generic-0.810.0.ebuild,v 1.2 2011/09/07 04:03:58 tove Exp $

EAPI=4

MODULE_AUTHOR=MUIR
MODULE_SECTION=modules
MODULE_VERSION=0.81
inherit perl-module

DESCRIPTION="Framework to provide start/stop/reload for a daemon"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-perl/File-Flock
		dev-perl/File-Slurp
		dev-perl/AnyEvent"
DEPEND="${RDEPEND}
		test? ( dev-perl/Eval-LineNumbers )"

SRC_TEST="do"
