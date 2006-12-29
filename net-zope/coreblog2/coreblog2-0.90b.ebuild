# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/coreblog2/coreblog2-0.90b.ebuild,v 1.2 2006/12/29 00:24:45 radek Exp $

inherit zproduct

DESCRIPTION="A Blog product working with Plone 2.1"
HOMEPAGE="http://coreblog.org/"
SRC_URI="${HOMEPAGE}/junk/COREBlog2_09b.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=net-zope/plone-2.1"

ZPROD_LIST="COREBlog2"
