# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/linux-gazette-base/linux-gazette-base-93.ebuild,v 1.1 2003/08/21 06:23:49 vapier Exp $

DESCRIPTION="Linux Gazette - common files"
HOMEPAGE="http://www.linuxgazette.com/"
SRC_URI="ftp://ftp.ssc.com/pub/lg/lg-base.tar.gz"

LICENSE="OPL"
SLOT="0"
KEYWORDS="x86 ppc"

S=${WORKDIR}/lg

src_install() {
	dodir /usr/share/doc/linux-gazette
	mv * ${D}/usr/share/doc/linux-gazette/
}
