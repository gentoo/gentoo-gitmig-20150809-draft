# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-3.0.1_p1.ebuild,v 1.2 2001/12/02 03:25:51 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Port of OpenBSD's free SSH release"
SRC_URI="ftp://ftp.openbsd.org/pub/unix/OpenBSD/OpenSSH/portable/${P}.tar.gz"
HOMEPAGE="http://www.openssh.com/"

RDEPEND="virtual/glibc pam? ( >=sys-libs/pam-0.73 ) >=dev-libs/openssl-0.9.6 sys-libs/zlib "
DEPEND="${RDEPEND} sys-devel/perl sys-apps/groff tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

src_compile() {

	local myconf
	use tcpd || myconf="${myconf} --without-tcp-wrappers"
	use tcpd && myconf="${myconf} --with-tcp-wrappers"
	use pam  || myconf="${myconf} --without-pam"
	use pam  && myconf="${myconf} --with-pam"

	./configure \
	--prefix=/usr \
	--sysconfdir=/etc/ssh \
	--mandir=/usr/share/man \
	--libexecdir=/usr/lib/misc \
	--datadir=/usr/share/openssh \
	--disable-suid-ssh \
	--with-ipv4-default \
	--host=${CHOST} ${myconf} || die "bad configure"

	if [ "`use static`" ]
	then
		# statically link to libcrypto -- good for the boot cd
		perl -pi -e "s|-lcrypto|/usr/lib/libcrypto.a|g" Makefile
	fi

	make || die " compile problem"
}

src_install() {                               

	make install-files DESTDIR=${D} || die
	dodoc ChangeLog CREDITS OVERVIEW README* TODO sshd_config

	insinto /etc/pam.d  ; newins ${FILESDIR}/sshd.pam.rc6 sshd
	exeinto /etc/init.d ; newexe ${FILESDIR}/sshd.rc6 sshd
}
