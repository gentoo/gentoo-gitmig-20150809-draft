# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kebuildpart/kebuildpart-0.3.ebuild,v 1.5 2002/07/27 10:44:28 seemant Exp $

inherit kde-base || die

need-kde 3
DESCRIPTION="Graphical KDE emerge kpart"
SRC_URI="mirror://sourceforge/kemerge/${P}.tar.gz"
HOMEPAGE="http://kemerge.sourceforge.net/"


LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack () {
	base_src_unpack

	# Fix silly absolute path problem. Author has been notified
	D=${S}/ dosed 's:/home/ykoehler/kebuildpart/kebuildpart/::' \
		kebuildpart/ebuildIface.kidl
}
