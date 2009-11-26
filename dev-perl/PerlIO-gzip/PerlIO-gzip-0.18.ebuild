# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlIO-gzip/PerlIO-gzip-0.18.ebuild,v 1.12 2009/11/26 17:30:19 maekke Exp $

MODULE_AUTHOR=NWCLARK
inherit perl-module

DESCRIPTION="PerlIO::Gzip - PerlIO layer to gzip/gunzip"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/perl-5.8
	sys-libs/zlib"
RDEPEND="${DEPEND}"

SRC_TEST="do"
