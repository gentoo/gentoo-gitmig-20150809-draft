# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/localizer/localizer-1.1.0_alpha1.ebuild,v 1.5 2006/01/27 02:37:45 vapier Exp $

inherit zproduct

PV_NEW=${PV/_/-}
DESCRIPTION="Helps to build multilingual zope websites and zope products"
HOMEPAGE="http://www.localizer.org"
SRC_URI="mirror://sourceforge/lleu/Localizer-${PV_NEW}.tgz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

DEPEND=""

ZPROD_LIST="Localizer"
MYDOC="BUGS.txt old/CHANGES.txt old/UPGRADE.txt RELEASE-*txt* ${MYDOC}"
