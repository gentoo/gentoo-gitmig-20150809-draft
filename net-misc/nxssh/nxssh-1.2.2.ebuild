# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxssh/nxssh-1.2.2.ebuild,v 1.2 2003/09/02 09:42:01 stuart Exp $

MY_P="${P}-5"
DESCRIPTION="Modified openssh client, used by nxclient"
HOMEPAGE="http://www.nomachine.com/"
SRC_URI="http://www.nomachine.com/download/nxsources/nxssh/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -mips -alpha"
DEPEND=""
# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""
IUSE="tcpd pam kerberos"

S=${WORKDIR}/${PN}

src_compile() {
	local myconf

	use tcpd || myconf="${myconf} --without-tcp-wrappers"
	use tcpd && myconf="${myconf} --with-tcp-wrappers"
	use pam  || myconf="${myconf} --without-pam"
	use pam  && myconf="${myconf} --with-pam"
	use ipv6 || myconf="${myconf} --with-ipv4-default"

	# app-crypt/mit-krb5
	use kerberos && myconf="${myconf} --with-kerberos5"

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
