# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Sablot/XML-Sablot-1.01.ebuild,v 1.13 2010/02/06 14:21:30 tove Exp $

EAPI=2

MY_PN=XML-Sablotron
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=PAVELH
inherit perl-module multilib

DESCRIPTION="Perl Module for Sablotron"

SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 GPL-3 )" # GPL-2+
KEYWORDS="alpha amd64 ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="app-text/sablotron
	dev-libs/expat"
DEPEND="${RDEPEND}"

myconf="SABLOTLIBPATH=/usr/$(get_libdir) SABLOTINCPATH=/usr/include"
