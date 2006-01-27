# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmf/cmf-1.5.1.ebuild,v 1.2 2006/01/27 02:26:41 vapier Exp $

inherit zproduct

MY_PN="CMF"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Content Management Framework. Services for content-oriented portal sites"
HOMEPAGE="http://cmf.zope.org/"
SRC_URI="http://www.zope.org/Products/${MY_PN}/${MY_P}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="1.5"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

S=${WORKDIR}/${MY_P}

ZPROD_LIST="CMFCalendar CMFCore CMFDefault CMFTopic DCWorkflow"
MYDOC="*.txt ${MYDOC}"
