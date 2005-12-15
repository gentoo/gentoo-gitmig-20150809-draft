# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/channelgen/channelgen-1.1.14.ebuild,v 1.1 2005/12/15 19:42:40 sanchan Exp $

CVS_MONTH="Jul"
CVS_YEAR="2005"
MY_P="tinyos"

DESCRIPTION="Channelgen verify the channel for CC1000Control, and generate \
a C-code preset-table entry for a given frequency"

HOMEPAGE="http://www.tinyos.net/"
SRC_URI="http://www.tinyos.net/dist-1.1.0/tinyos/source/${MY_P}-${PV}${CVS_MONTH}${CVS_YEAR}cvs.tar.gz"
LICENSE="Intel"
SLOT="1"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-devel/make \
	sys-devel/gcc"
RDEPEND=""
S=${WORKDIR}/tinyos-1.x/tools/src/CC1000

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	mv ${MY_P}-${PV}${CVS_MONTH}${CVS_YEAR}cvs tinyos-1.x
}

src_compile() {
	cd ${S}
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	dodir /usr/bin
	make prefix=${D}/usr install  || die "install failed"
}
