# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Flock/File-Flock-2008.01.ebuild,v 1.3 2009/10/27 09:11:46 volkmar Exp $

MODULE_AUTHOR="MUIR"
MODULE_SECTION="modules"

inherit perl-module

DESCRIPTION="flock() wrapper.  Auto-create locks"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

SRC_TEST="do"
