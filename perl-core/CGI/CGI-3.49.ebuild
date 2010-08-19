# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CGI/CGI-3.49.ebuild,v 1.2 2010/08/19 15:05:56 hwoarang Exp $

EAPI=2

MODULE_AUTHOR=LDS
MY_PN=${PN}.pm
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Simple Common Gateway Interface Class"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

#DEPEND="dev-lang/perl"
#	dev-perl/FCGI" #236921

SRC_TEST="do"
