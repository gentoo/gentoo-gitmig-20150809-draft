# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosip/libosip-2.0.7.ebuild,v 1.7 2004/10/31 20:47:05 kloeri Exp $

IUSE="debug"

DESCRIPTION="GNU oSIP (Open SIP) library version 2"
HOMEPAGE="http://www.gnu.org/software/osip/"
SRC_URI="mirror://gnu/osip/libosip2-${PV}.tar.gz"
S="${WORKDIR}/libosip2-${PV}"

SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="LGPL-2"

DEPEND="virtual/libc
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
