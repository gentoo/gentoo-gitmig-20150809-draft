# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/YAML-Syck/YAML-Syck-1.14.ebuild,v 1.1 2010/08/28 07:20:39 tove Exp $

EAPI=3

MODULE_AUTHOR=TODDR
inherit perl-module

DESCRIPTION="Fast, lightweight YAML loader and dumper"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="|| ( dev-libs/syck >=dev-lang/ruby-1.8 )"
RDEPEND="${DEPEND}"

SRC_TEST="do"
