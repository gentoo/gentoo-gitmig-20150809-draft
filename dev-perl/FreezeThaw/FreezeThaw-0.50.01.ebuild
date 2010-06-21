# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FreezeThaw/FreezeThaw-0.50.01.ebuild,v 1.3 2010/06/21 19:58:35 armin76 Exp $

EAPI=2

inherit versionator
MY_P=${PN}-$(delete_version_separator 2 )
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=ILYAZ
MODULE_SECTION=modules
inherit perl-module

DESCRIPTION="converting Perl structures to strings and back"

SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~ppc s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST=do
