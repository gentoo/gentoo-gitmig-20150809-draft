# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmf/cmf-1.4.ebuild,v 1.1 2003/06/21 08:15:04 kutsuya Exp $

inherit zproduct
S=${WORKDIR}/CMF-${PV}

DESCRIPTION="Content Management Framework. Services for content-oriented portal sites."

HOMEPAGE="http://cmf.zope.org/"
SRC_URI="${HOMEPAGE}/download/CMF-${PV}/CMF-${PV}.tar.gz"
SLOT=1.4
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"

ZPROD_LIST="CMFCalendar CMFCore CMFDefault CMFTopic"
MYDOC="DEPENDENCIES.txt INSTALL_CVS.txt ${MYDOC}"






