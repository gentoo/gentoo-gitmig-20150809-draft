# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FileHandle-Unget/FileHandle-Unget-0.16.22.ebuild,v 1.1 2008/09/09 09:13:59 tove Exp $

MODULE_AUTHOR=DCOPPIT
inherit perl-module versionator

MY_P="${PN}-$(delete_version_separator 2 )"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A FileHandle which supports ungetting of multiple bytes"
SRC_URI="mirror://cpan/authors/id/D/DC/DCOPPIT/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST=do
