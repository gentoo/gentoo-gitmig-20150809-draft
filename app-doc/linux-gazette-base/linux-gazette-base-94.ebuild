# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/linux-gazette-base/linux-gazette-base-94.ebuild,v 1.1 2003/09/13 19:04:23 vapier Exp $

# the SRC_URI always has the same file name ... make sure you
# `rm ${DISTDIR}/lg-base.tar.gz` and make a new digest with
# every version bump

DESCRIPTION="Linux Gazette - common files"
HOMEPAGE="http://www.linuxgazette.com/"
SRC_URI="mirror://gentoo/lg-base-${PV}.tar.gz"
#SRC_URI="ftp://ftp.ssc.com/pub/lg/lg-base.tar.gz"

LICENSE="OPL"
SLOT="0"
KEYWORDS="x86 ppc"

S=${WORKDIR}/lg

src_install() {
	dodir /usr/share/doc/linux-gazette
	mv * ${D}/usr/share/doc/linux-gazette/
}
