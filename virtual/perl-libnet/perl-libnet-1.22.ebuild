# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-libnet/perl-libnet-1.22.ebuild,v 1.9 2009/12/10 21:43:53 ranger Exp $

DESCRIPTION="Virtual for libnet"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"

IUSE=""
DEPEND=""
RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/libnet-${PV} )"
