# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kebuildpart/kebuildpart-0.3.ebuild,v 1.3 2002/07/17 20:43:16 drobbins Exp $

inherit kde-base || die

need-kde 3
DESCRIPTION="Graphical KDE emerge kpart"
SRC_URI="mirror://sourceforge/kemerge/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://kemerge.sourceforge.net/"
LICENSE="GPL-2"

src_unpack () {
	base_src_unpack

	# Fix silly absolute path problem. Author has been notified
	D=${S}/ dosed 's:/home/ykoehler/kebuildpart/kebuildpart/::' \
		kebuildpart/ebuildIface.kidl
}
