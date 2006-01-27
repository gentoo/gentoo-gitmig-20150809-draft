# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/localizer/localizer-1.0.1.ebuild,v 1.6 2006/01/27 02:37:45 vapier Exp $

inherit zproduct

DESCRIPTION="Helps to build multilingual zope websites and zope products"
HOMEPAGE="http://www.localizer.org"
SRC_URI="mirror://sourceforge/lleu/Localizer-${PV}.tgz"

LICENSE="GPL-2"

DEPEND=""

ZPROD_LIST="Localizer"
MYDOC="BUGS.txt old/CHANGES.txt old/UPGRADE.txt RELEASE-*txt* ${MYDOC}"
