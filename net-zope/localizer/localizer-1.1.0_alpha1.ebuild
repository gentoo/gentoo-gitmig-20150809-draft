# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/localizer/localizer-1.1.0_alpha1.ebuild,v 1.1 2003/06/26 16:27:41 kutsuya Exp $

inherit zproduct
PV_NEW=${PV/_/-}

DESCRIPTION="Helps to build multilingual zope websites and zope products."
HOMEPAGE="http://www.localizer.org"
SRC_URI="http://unc.dl.sourceforge.net/lleu/Localizer-${PV_NEW}.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

ZPROD_LIST="Localizer"
MYDOC="BUGS.txt old/CHANGES.txt old/UPGRADE.txt RELEASE-*txt* ${MYDOC}"


