# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxssh/nxssh-1.4.0-r1.ebuild,v 1.2 2005/02/17 12:54:15 stuart Exp $

MY_P="${PN}-${PV}-21"
DESCRIPTION="Modified openssh client, used by nxclient"
HOMEPAGE="http://www.nomachine.com/"
SRC_URI="http://www.nomachine.com/download/nxsources/nxssh/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"
DEPEND=">=dev-libs/openssl-0.9.7d-r1
	    >=sys-libs/glibc-2.3.3.20040420-r1
	    >=sys-libs/zlib-1.2.1-r2
		tcpd? ( sys-apps/tcp-wrappers )
		pam? ( sys-libs/pam )"
# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""
IUSE="ipv6 pam tcpd"

S=${WORKDIR}/${PN}

src_compile() {
	local myconf

	use tcpd || myconf="${myconf} --without-tcp-wrappers"
	use tcpd && myconf="${myconf} --with-tcp-wrappers"
	use pam  || myconf="${myconf} --without-pam"
	use pam  && myconf="${myconf} --with-pam"
	use ipv6 || myconf="${myconf} --with-ipv4-default"

	./configure \
	    --prefix=/usr \
		--sysconfdir=/etc/ssh \
		--mandir=/usr/share/man \
		--libexecdir=/usr/lib/misc \
		--datadir=/usr/share/openssh \
		--disable-suid-ssh \
		--with-privsep-path=/var/empty \
		--with-privsep-user=sshd \
		--with-md5-passwords \
		--host=${CHOST} ${myconf} || die "bad configure"

	emake || die "compile problem"
}

src_install() {
	exeinto /usr/NX/bin
	doexe nxssh
}
