# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses-UI/Curses-UI-0.960.900.ebuild,v 1.4 2012/02/27 03:40:42 jer Exp $

EAPI=4

MODULE_AUTHOR=MDXI
MODULE_VERSION=0.9609
inherit perl-module

DESCRIPTION="Perl UI framework based on the curses library"

SLOT="0"
KEYWORDS="amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-perl/Curses
	dev-perl/TermReadKey"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
	)"

SRC_TEST="do"
