# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/koncd/koncd-1.0_rc1.ebuild,v 1.3 2001/11/16 12:50:41 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2.2

S=${WORKDIR}/koncd-1.0rc1
DESCRIPTION="A KDE frontend to cdr apps; very powerful"
SRC_URI="http://www.koncd.org/download/koncd-1.0rc1.tar.gz"
HOMEPAGE="http://www.koncd.org/"

DEPEND="$DEPEND >=app-cdr/cdrtools-1.11"
RDEPEND="$RDEPEND >=app-cdr/cdrtools-1.11"

src_unpack() {
    base_src_unpack
    kde-objprelink-patch
}




