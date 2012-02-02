# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Plack/Plack-0.998.500.ebuild,v 1.1 2012/02/02 19:02:47 tove Exp $

EAPI=4

MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=0.9985
inherit perl-module

DESCRIPTION="PSGI toolkit and servers"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/libwww-perl-5.814.0
	>=dev-perl/URI-1.360.0
	virtual/perl-PodParser
	>=dev-perl/File-ShareDir-1.0.0
	dev-perl/Try-Tiny
	virtual/perl-parent
	>=dev-perl/Devel-StackTrace-1.230.0
	>=dev-perl/Devel-StackTrace-AsHTML-0.110.0
	dev-perl/Filesys-Notify-Simple
	>=dev-perl/Hash-MultiValue-0.50.0
	>=dev-perl/HTTP-Body-1.60.0
	>=dev-perl/Test-TCP-0.110.0
"
DEPEND="${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-0.88
		dev-perl/Test-Requires
	)"

SRC_TEST=do
