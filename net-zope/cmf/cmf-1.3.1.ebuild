# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmf/cmf-1.3.1.ebuild,v 1.5 2004/01/29 13:18:22 lanius Exp $

inherit zproduct
S=${WORKDIR}/CMF-${PV}

DESCRIPTION="Content Management Framework. Services for content-oriented portal sites."

HOMEPAGE="http://cmf.zope.org/"
SRC_URI="${HOMEPAGE}/download/CMF-${PV}/CMF-${PV}.tar.gz"
SLOT=1.3
LICENSE="ZPL"
KEYWORDS="x86"

ZPROD_LIST="CMFCalendar CMFCore CMFDefault CMFTopic"
MYDOC="DEPENDENCIES.txt INSTALL_CVS.txt ${MYDOC}"






