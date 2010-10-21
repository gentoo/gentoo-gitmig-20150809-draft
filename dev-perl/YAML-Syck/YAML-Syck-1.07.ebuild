# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/YAML-Syck/YAML-Syck-1.07.ebuild,v 1.3 2010/10/21 17:02:31 armin76 Exp $

EAPI=2

MODULE_AUTHOR=AUDREYT
inherit perl-module

DESCRIPTION="Fast, lightweight YAML loader and dumper"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="|| ( dev-libs/syck >=dev-lang/ruby-1.8 )"
RDEPEND="${DEPEND}"

SRC_TEST="do"
