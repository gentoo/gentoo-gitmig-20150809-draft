# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmf/cmf-1.4.2.ebuild,v 1.2 2004/01/29 13:18:22 lanius Exp $

inherit zproduct

DESCRIPTION="Content Management Framework. Services for content-oriented portal sites."

HOMEPAGE="http://cmf.zope.org/"
MY_PN="CMF"
MY_P="${MY_PN}-${PV}"
SRC_URI="${HOMEPAGE}/download/${MY_P}/${MY_P}.tar.gz"
SLOT=1.4
LICENSE="ZPL"
KEYWORDS="~x86"

ZPROD_LIST="CMFCalendar CMFCore CMFDefault CMFTopic DCWorkflow"
MYDOC="*.txt ${MYDOC}"
S=${WORKDIR}/${MY_P}
