# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/YAML-Syck/YAML-Syck-1.09.ebuild,v 1.1 2010/05/31 08:08:57 tove Exp $

EAPI=3

MODULE_AUTHOR=AVAR
inherit perl-module

DESCRIPTION="Fast, lightweight YAML loader and dumper"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="|| ( dev-libs/syck >=dev-lang/ruby-1.8 )"
RDEPEND="${DEPEND}"

SRC_TEST="do"
