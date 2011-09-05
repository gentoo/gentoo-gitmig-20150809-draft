# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses-UI/Curses-UI-0.960.900.ebuild,v 1.1 2011/09/05 16:46:25 tove Exp $

EAPI=4

MODULE_AUTHOR=MDXI
MODULE_VERSION=0.9609
inherit perl-module

DESCRIPTION="Perl UI framework based on the curses library"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Curses
	dev-perl/TermReadKey"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
	)"

SRC_TEST="do"
