# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/localizer/localizer-1.0.1.ebuild,v 1.1 2003/04/09 18:07:43 kutsuya Exp $

inherit zproduct

DESCRIPTION="Helps to build multilingual zope websites and zope products."
HOMEPAGE="http://www.localizer.org"
SRC_URI="http://unc.dl.sourceforge.net/lleu/Localizer-${PV}.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

ZPROD_LIST="Localizer"
DOTTXT_PROTECT="languages.txt charsets.txt ${DOTTXT_PROTECT}"

