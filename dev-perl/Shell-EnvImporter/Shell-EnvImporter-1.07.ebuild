# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Shell-EnvImporter/Shell-EnvImporter-1.07.ebuild,v 1.11 2010/01/11 19:38:52 grobian Exp $

EAPI=2

MODULE_AUTHOR=DFARALDO
inherit perl-module

DESCRIPTION="Import environment variable changes from external commands or shell scripts"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=">=dev-perl/Class-MethodMaker-2"
RDEPEND="${DEPEND}"

SRC_TEST=no
