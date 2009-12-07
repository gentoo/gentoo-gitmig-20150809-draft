# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CGI/CGI-3.48.ebuild,v 1.3 2009/12/07 11:35:42 maekke Exp $

EAPI=2

MODULE_AUTHOR=LDS
MY_PN=${PN}.pm
MY_P=${MY_PN}-${PV}
inherit perl-module

DESCRIPTION="Simple Common Gateway Interface Class"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

#DEPEND="dev-lang/perl"
#	dev-perl/FCGI" #236921

S=${WORKDIR}/${MY_P}

SRC_TEST="do"

PATCHES=( "${FILESDIR}"/3.47-fcgi.patch )
