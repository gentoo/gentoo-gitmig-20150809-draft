# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmf/cmf-1.3.2.ebuild,v 1.7 2005/02/21 21:23:00 blubb Exp $

inherit zproduct

DESCRIPTION="Content Management Framework. Services for content-oriented portal sites."

HOMEPAGE="http://cmf.zope.org/"
MY_PN="CMF"
MY_P="${MY_PN}-${PV}"
SRC_URI="${HOMEPAGE}/download/${MY_P}/${MY_P}.tar.gz"
SLOT=1.3
LICENSE="ZPL"
KEYWORDS="x86 ~ppc"
IUSE=""

ZPROD_LIST="CMFCalendar CMFCore CMFDefault CMFTopic"
MYDOC="*.txt ${MYDOC}"
S=${WORKDIR}/${MY_P}
