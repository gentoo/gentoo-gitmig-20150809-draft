# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/calendarx/calendarx-0.4.15.ebuild,v 1.1 2005/04/19 17:03:05 radek Exp $

inherit zproduct

DESCRIPTION="CalendarX is a customizable calendar product for Plone."
HOMEPAGE="http://calendarx.org/"
SRC_URI="mirror://sourceforge/${PN}//CalendarX-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=net-zope/plone-2.0*"

ZPROD_LIST="CalendarX"

src_install()
{
	# We need to change directory name to versionless
	mv ${ZPROD_LIST}-${PV} ${ZPROD_LIST}
	zproduct_src_install
}
