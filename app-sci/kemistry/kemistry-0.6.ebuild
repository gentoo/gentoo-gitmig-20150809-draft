# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/kemistry/kemistry-0.6.ebuild,v 1.1 2002/10/23 15:06:06 hannes Exp $

inherit kde-base
need-kde 3.0
IUSE=""
KEYWORDS="~x86"
LICENSE="GPL-2"
S="${WORKDIR}/${PN}"
DESCRIPTION="Kemistry--a set of chemistry related tools for KDE."
SRC_URI="mirror://sourceforge/kemistry/${P}.tar.bz2"
HOMEPAGE="http://kemistry.sourceforge.net"


