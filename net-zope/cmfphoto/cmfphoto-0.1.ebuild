# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public Form License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfphoto/cmfphoto-0.1.ebuild,v 1.1 2003/03/08 11:12:44 kutsuya Exp $

inherit zproduct

DESCRIPTION="Zope product to have photos."
HOMEPAGE="http://sourceforge.net/projects/collective/"
SRC_URI="mirror://sourceforge/collective/CMFPhoto-${PV}.tar.gz"
LICENSE="GPL"
KEYWORDS="~x86"
RDEPEND="dev-python/Imaging-py21
	    ${RDEPEND}"

ZPROD_LIST="CMFPhoto"

