# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Module-Pluggable/perl-Module-Pluggable-3.9.ebuild,v 1.14 2011/01/22 10:11:43 tove Exp $

DESCRIPTION="automatically give your module the ability to have plugins"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="|| ( ~dev-lang/perl-5.12.3 ~dev-lang/perl-5.12.2 ~dev-lang/perl-5.10.1 ~perl-core/Module-Pluggable-${PV} )"
