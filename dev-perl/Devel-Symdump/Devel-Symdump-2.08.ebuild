# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Symdump/Devel-Symdump-2.08.ebuild,v 1.8 2010/11/15 09:58:42 grobian Exp $

inherit versionator perl-module

MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}

DESCRIPTION="dump symbol names or the symbol table"
HOMEPAGE="http://search.cpan.org/~andk/"
SRC_URI="mirror://cpan/authors/id/A/AN/ANDK/${MY_P}.tar.gz"

SRC_TEST="do"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-lang/perl"
