# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/enet/enet-0_pre20031103.ebuild,v 1.3 2004/01/30 06:58:43 drobbins Exp $

#ECVS_SERVER=sferik.cubik.org:/home/enet/cvsroot
#ECVS_USER=anoncvs
ECVS_MODULE=enet
#inherit cvs

DESCRIPTION="relatively thin, simple and robust network communication layer on top of UDP"
HOMEPAGE="http://enet.cubik.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-devel/autoconf-2.58"
RDEPEND=""

S=${WORKDIR}/${ECVS_MODULE}

src_unpack() {
	if [ -z "${ECVS_SERVER}" ] ; then
		unpack ${A}
	else
		cvs_src_unpack
	fi
	cd ${S}
	export WANT_AUTOCONF=2.5
	aclocal || die "aclocal"
	automake -a || die "automake"
	autoconf || die "autoconf"
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc *.txt README
}
