# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Rar/Archive-Rar-1.9.3.ebuild,v 1.1 2007/11/19 18:59:14 ian Exp $

inherit perl-module versionator

MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Archive::Rar - Interface with the rar command"
HOMEPAGE="http://search.cpan.org/~smueller/"
SRC_URI="mirror://cpan/authors/id/S/SM/SMUELLER/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
DEPEND="dev-lang/perl
		app-arch/rar
		test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
