# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/kconfigure/kconfigure-1.1.ebuild,v 1.1 2002/05/11 16:28:41 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base

need-kde 2

DESCRIPTION="A GUI frontend for kde-style configure/make/make install packages"
SRC_URI="http://unc.dl.sourceforge.net/${PN}/${P}.tar.gz
	 http://telia.dl.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net"
