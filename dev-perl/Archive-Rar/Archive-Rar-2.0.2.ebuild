# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Rar/Archive-Rar-2.0.2.ebuild,v 1.2 2009/01/20 14:15:26 tove Exp $

inherit versionator
MODULE_AUTHOR=SMUELLER
MY_P="${PN}-$(delete_version_separator 2)"
inherit perl-module

S=${WORKDIR}/${MY_P}

DESCRIPTION="Archive::Rar - Interface with the rar command"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-lang/perl
	virtual/perl-IPC-Cmd
	app-arch/rar"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
