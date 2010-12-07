# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Script/Test-Script-1.07.ebuild,v 1.6 2010/12/07 04:59:20 mattst88 Exp $

EAPI=2

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Cross-platform basic tests for scripts"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ~ppc ~ppc64 ~s390 ~sh sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="virtual/perl-File-Spec
	dev-perl/Probe-Perl
	dev-perl/IPC-Run3
	virtual/perl-Test-Simple"
DEPEND="${RDEPEND}"

SRC_TEST=do
