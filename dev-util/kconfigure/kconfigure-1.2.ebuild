# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kconfigure/kconfigure-1.2.ebuild,v 1.3 2003/04/05 22:04:42 danarmak Exp $
inherit kde-base

need-kde 3

DESCRIPTION="A GUI frontend for kde-style configure/make/make install packages"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86"
