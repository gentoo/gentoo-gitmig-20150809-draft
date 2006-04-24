# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-libnet/perl-libnet-1.19.ebuild,v 1.3 2006/04/24 15:30:20 flameeyes Exp $

DESCRIPTION="Virtual for libnet"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

IUSE=""
DEPEND=""
RDEPEND="|| ( >=dev-lang/perl-5.8.7 ~perl-core/libnet-${PV} )"

