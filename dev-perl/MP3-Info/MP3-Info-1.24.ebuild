# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MP3-Info/MP3-Info-1.24.ebuild,v 1.3 2010/11/11 22:02:30 hwoarang Exp $

MODULE_AUTHOR=DANIEL
inherit perl-module

DESCRIPTION="A Perl module to manipulate/fetch info from MP3 files"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
