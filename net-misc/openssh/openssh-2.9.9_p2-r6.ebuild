# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# /home/cvsroot/gentoo-x86/net-misc/openssh/openssh-2.9_p2-r6.ebuild,v 1.1 2001/09/07 09:07:37 woodchip Exp

P=openssh-2.9.9p2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Port of OpenBSD's free SSH release"
SRC_URI="ftp://ftp.openbsd.org/pub/unix/OpenBSD/OpenSSH/portable/${A}"
HOMEPAGE="http://www.openssh.com/"

DEPEND="virtual/glibc sys-devel/perl sys-apps/groff
        tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
        pam? ( >=sys-libs/pam-0.73 )
        >=dev-libs/openssl-0.9.6
        sys-libs/zlib"

RDEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.73 )
	>=dev-libs/openssl-0.9.6
	sys-libs/zlib"

src_compile() {

    local myconf
    use tcpd && myconf="${myconf} --with-tcp-wrappers"
    use tcpd || myconf="${myconf} --without-tcp-wrappers"
    use pam  && myconf="${myconf} --with-pam"
    use pam  || myconf="${myconf} --without-pam"

    ./configure --prefix=/usr --sysconfdir=/etc/ssh --host=${CHOST} \
	--libexecdir=/usr/lib/misc --mandir=/usr/share/man \
	--with-ipv4-default --disable-suid-ssh ${myconf}
    assert
    make || die
}

src_install() {                               

    make install-files DESTDIR=${D} || die
    dodoc ChangeLog CREDITS OVERVIEW README* TODO sshd_config

    insinto /etc/pam.d
    newins ${FILESDIR}/sshd.pam.rc6 sshd
    exeinto /etc/init.d
    newexe ${FILESDIR}/sshd.rc6 sshd
}
