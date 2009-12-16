# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/IO/IO-1.23.01.ebuild,v 1.12 2009/12/16 21:50:28 abcd Exp $

inherit versionator perl-module

MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}

DESCRIPTION="load various IO modules"
HOMEPAGE="http://search.cpan.org/~gbarr"
SRC_URI="mirror://cpan/authors/id/G/GB/GBARR/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 mips ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND="dev-lang/perl"
