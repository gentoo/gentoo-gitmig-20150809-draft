# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Module-Pluggable/perl-Module-Pluggable-3.9.ebuild,v 1.8 2009/08/25 10:56:58 tove Exp $

DESCRIPTION="automatically give your module the ability to have plugins"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Module-Pluggable-${PV} )"
