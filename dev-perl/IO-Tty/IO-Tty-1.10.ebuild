# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Tty/IO-Tty-1.10.ebuild,v 1.2 2011/03/30 16:42:59 jer Exp $

EAPI=3

MODULE_AUTHOR=TODDR
inherit perl-module

DESCRIPTION="IO::Tty and IO::Pty modules for Perl"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

SRC_TEST=do
