# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-SHA1/Digest-SHA1-2.12.ebuild,v 1.1 2009/05/24 09:15:55 tove Exp $

EAPI=2

MODULE_AUTHOR=GAAS
inherit perl-module

DESCRIPTION="NIST SHA message digest algorithm"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND="virtual/perl-digest-base"
RDEPEND="${DEPEND}"

SRC_TEST="do"
