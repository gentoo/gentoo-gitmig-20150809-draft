# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kebuildpart/kebuildpart-0.3-r1.ebuild,v 1.8 2002/08/16 02:21:27 murphy Exp $

inherit kde-base || die

need-kde 3
DESCRIPTION="Graphical KDE emerge kpart"
SRC_URI="mirror://sourceforge/kemerge/${P}.tar.gz"
HOMEPAGE="http://kemerge.sourceforge.net/"


LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64" #does not compile on ppc with qt version 3.0.4 nor 3.0.5 - see Changelog

src_unpack () {
	base_src_unpack

	# Fix silly absolute path problem. Author has been notified
	D=${S}/ dosed 's:/home/ykoehler/kebuildpart/kebuildpart/::' \
		kebuildpart/ebuildIface.kidl
}

src_install() {

	kde_src_install
	
	# for some reason this include file is left out.
	# i'll notify the author.
	cp ${S}/kebuildpart/kebuildview.h ${D}/${KDEDIR}/include/kebuild/
}
