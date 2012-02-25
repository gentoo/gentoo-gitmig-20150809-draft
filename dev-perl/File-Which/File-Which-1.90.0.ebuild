# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Which/File-Which-1.90.0.ebuild,v 1.3 2012/02/25 17:53:53 klausman Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.09
inherit perl-module

DESCRIPTION="Perl module implementing 'which' internally"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="test? ( >=dev-perl/Test-Script-1.06 )"

SRC_TEST="do"
