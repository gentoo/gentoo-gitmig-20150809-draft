# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/enet/enet-0_pre20030720.ebuild,v 1.1 2003/07/22 04:16:53 vapier Exp $

ECVS_SERVER=sferik.cubik.org:/home/enet/cvsroot
ECVS_USER=anoncvs
ECVS_MODULE=enet
inherit cvs

DESCRIPTION="relatively thin, simple and robust network communication layer on top of UDP"
HOMEPAGE="http://enet.cubik.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	make COPTFLAGS="${CFLAGS}" || die
}

src_install() {
	insinto /usr/include/enet
	doins include/enet/*.h
	dolib.a libenet.a
	dodoc *.txt
}
