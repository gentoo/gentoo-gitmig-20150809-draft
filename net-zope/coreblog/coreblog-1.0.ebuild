# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/coreblog/coreblog-1.0.ebuild,v 1.2 2004/10/14 20:52:19 radek Exp $

inherit zproduct

NEW_PV="${PV//./-}"

DESCRIPTION="Blog/Weblog/Web Nikki system for Zope."
HOMEPAGE="http://coreblog.org/"
SRC_URI="${HOMEPAGE}/junk/COREBlog10.tgz"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

ZPROD_LIST="COREBlog"
