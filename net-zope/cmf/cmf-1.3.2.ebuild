# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmf/cmf-1.3.2.ebuild,v 1.1 2003/10/10 21:58:21 robbat2 Exp $

inherit zproduct
S=${WORKDIR}/CMF-${PV}

DESCRIPTION="Content Management Framework. Services for content-oriented portal sites."

HOMEPAGE="http://cmf.zope.org/"
SRC_URI="${HOMEPAGE}/download/CMF-${PV}/CMF-${PV}.tar.gz"
SLOT=1.3
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"

ZPROD_LIST="CMFCalendar CMFCore CMFDefault CMFTopic"
MYDOC="DEPENDENCIES.txt INSTALL_CVS.txt ${MYDOC}"






