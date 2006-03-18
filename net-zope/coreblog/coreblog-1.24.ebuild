# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/coreblog/coreblog-1.24.ebuild,v 1.1 2006/03/18 18:15:07 radek Exp $

inherit zproduct

NEW_PV="${PV//./-}"
DESCRIPTION="Blog/Weblog/Web Nikki system for Zope (1.2.4)"
HOMEPAGE="http://coreblog.org/"
SRC_URI="${HOMEPAGE}/junk/COREBlog124.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

ZPROD_LIST="COREBlog"
