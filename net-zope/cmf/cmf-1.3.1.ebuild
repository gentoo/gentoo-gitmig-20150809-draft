# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmf/cmf-1.3.1.ebuild,v 1.2 2003/04/04 03:15:41 kutsuya Exp $

inherit zproduct

DESCRIPTION="Zope Content Management Framework. Services for content-oriented portal sites."

HOMEPAGE="http://cmf.zope.org/"
SRC_URI="${HOMEPAGE}/download/CMF-${PV}/CMF-${PV}.tar.gz"
S=${WORKDIR}/CMF-${PV}

LICENSE="ZPL"
KEYWORDS="x86 ~ppc"

ZPROD_LIST="CMFCalendar CMFCore CMFDefault CMFTopic"






