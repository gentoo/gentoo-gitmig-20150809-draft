# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/kdar/kdar-0.3.2.ebuild,v 1.1 2003/11/13 00:05:44 matsuu Exp $

inherit kde-base
need-kde 3

DESCRIPTION="a KDE frontend to Denis Corbin's libdar 1.0"
HOMEPAGE="http://members.shaw.ca/jkerrb/kdar/"
SRC_URI="http://members.shaw.ca/jkerrb/kdar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

newdepend "app-arch/dar"
