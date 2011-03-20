# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ReadLine-Gnu/Term-ReadLine-Gnu-1.200.0.ebuild,v 1.2 2011/03/20 18:25:38 armin76 Exp $

EAPI=3

MODULE_AUTHOR=HAYASHI
MODULE_VERSION=1.20
inherit perl-module

DESCRIPTION="GNU Readline XS library wrapper"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc sparc x86"
IUSE=""

DEPEND="<sys-libs/readline-6.2"
RDEPEND="${DEPEND}"

#SRC_TEST="do"
