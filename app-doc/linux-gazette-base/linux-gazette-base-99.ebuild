# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/linux-gazette-base/linux-gazette-base-99.ebuild,v 1.4 2004/06/30 01:36:40 agriffis Exp $

# the SRC_URI always has the same file name ... make sure you
# `rm ${DISTDIR}/lg-base.tar.gz` and make a new digest with
# every version bump

DESCRIPTION="Linux Gazette - common files"
HOMEPAGE="http://linuxgazette.net/"
SRC_URI="mirror://gentoo/lg-base-${PV}.tar.gz"
#SRC_URI="http://linuxgazette.net/ftpfiles/lg-base.tar.gz"

LICENSE="OPL"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

S=${WORKDIR}/lg

src_install() {
	dodir /usr/share/doc/linux-gazette
	mv * ${D}/usr/share/doc/linux-gazette/
}
