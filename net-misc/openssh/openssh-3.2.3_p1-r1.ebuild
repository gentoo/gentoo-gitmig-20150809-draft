# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-3.2.3_p1-r1.ebuild,v 1.1 2002/06/04 23:20:50 stroke Exp $

DESCRIPTION="Port of OpenBSD's free SSH release"
HOMEPAGE="http://www.openssh.com/"

# openssh recognizes when openssl has been slightly upgraded and refuses to run.
# This new rev will use the new openssl.
RDEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.73 >=sys-apps/shadow-4.0.2-r2 )
	>=dev-libs/openssl-0.9.6d
	sys-libs/zlib"

DEPEND="${RDEPEND}
	sys-devel/perl
	sys-apps/groff
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

# Make it more portable between straight releases
# and _p? releases.
PARCH=${P/_/}

SRC_URI="ftp://ftp.openbsd.org/pub/unix/OpenBSD/OpenSSH/portable/${PARCH}.tar.gz"
S=${WORKDIR}/${PARCH}

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
	insinto /etc/pam.d  ; newins ${FILESDIR}/sshd.pam sshd
	exeinto /etc/init.d ; newexe ${FILESDIR}/sshd.rc6 sshd
}
