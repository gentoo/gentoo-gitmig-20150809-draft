# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Rar/Archive-Rar-1.9.2.ebuild,v 1.1 2007/01/05 19:00:00 mcummings Exp $

inherit perl-module versionator

MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Archive::Rar - Interface with the rar command"
HOMEPAGE="http://search.cpan.org/~smueller/"
SRC_URI="mirror://cpan/authors/id/S/SM/SMUELLER/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-lang/perl
		app-arch/rar"

SRC_TEST="do"
