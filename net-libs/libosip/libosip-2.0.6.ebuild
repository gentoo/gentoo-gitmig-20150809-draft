# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosip/libosip-2.0.6.ebuild,v 1.1 2004/03/14 16:09:20 stkn Exp $

IUSE=""

DESCRIPTION="GNU oSIP (Open SIP) library version 2"
HOMEPAGE="http://www.gnu.org/software/osip/"
SRC_URI="http://osip.atosc.org/download/osip/libosip2-${PV}.tar.gz"
S="${WORKDIR}/libosip2-${PV}"

SLOT="2"
KEYWORDS="~x86"
LICENSE="LGPL-2"

DEPEND="virtual/glibc
	dev-util/gperf"

src_compile() {
	local myconf

	myconf="--enable-gperf --enable-mt --enable-md5"

	use debug && \
		myconf="${myconf} --enable-debug"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README ChangeLog INSTALL AUTHORS COPYING NEWS BUGS TODO
}
