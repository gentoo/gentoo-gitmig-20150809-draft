# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/coreblog/coreblog-1.11.ebuild,v 1.1 2005/03/26 01:00:24 radek Exp $

inherit zproduct

NEW_PV="${PV//./-}"

DESCRIPTION="Blog/Weblog/Web Nikki system for Zope."
HOMEPAGE="http://coreblog.org/"
SRC_URI="${HOMEPAGE}/junk/COREBlog111.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

ZPROD_LIST="COREBlog"
