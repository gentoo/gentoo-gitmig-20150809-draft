# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kconfigure/kconfigure-1.1.ebuild,v 1.3 2002/07/23 11:22:19 seemant Exp $

inherit kde-base

need-kde 2

DESCRIPTION="A GUI frontend for kde-style configure/make/make install packages"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
