# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmf/cmf-1.3.ebuild,v 1.1 2003/03/03 22:18:31 kutsuya Exp $

inherit zproduct

DESCRIPTION="Zope Content Management Framework. Services for content-oriented portal sites."

HOMEPAGE="http://cmf.zope.org/"
SRC_URI="${HOMEPAGE}/download/CMF-${PV}/CMF-${PV}.tar.gz"
S=${WORKDIR}/CMF-${PV}

LICENSE="ZPL"
KEYWORDS="~x86"

ZPROD_LIST="CMFCalendar CMFCore CMFDefault CMFTopic"






