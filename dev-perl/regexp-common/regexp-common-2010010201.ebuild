# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/regexp-common/regexp-common-2010010201.ebuild,v 1.6 2010/06/27 19:25:19 nixnut Exp $

EAPI=2

MODULE_AUTHOR=ABIGAIL
MY_PN=Regexp-Common
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Provide commonly requested regular expressions"

LICENSE="|| ( Artistic Artistic-2 MIT BSD )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"
