# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ssh/ssh-3.2.9.1-r1.ebuild,v 1.1 2005/01/13 23:09:14 humpback Exp $

inherit gnuconfig eutils

DESCRIPTION="SSH.COM free for Non-Commercial Use ssh version"
HOMEPAGE="http://www.ssh.com/"
SRC_URI="ftp://ftp.ssh.com/pub/ssh/${P}.tar.gz"

LICENSE="ssh"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="X ipv6 crypt openssh"

DEPEND="X? ( virtual/x11 )
	!openssh? ( !virtual/ssh )"
PROVIDE="virtual/ssh"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/patch-readline.diff
}

src_compile() {
	gnuconfig_update

	econf \
		`use_with ipv6 ipv6` \
		`use_with X` \
		`use_with crypt gpg` \
		|| die "configure failed"
	make || die "make failed"
}

src_install() {
	if [ -e ${ROOT}/etc/ssh2/hostkey ] ; then
		# this keeps the install from generating these keys again
		insinto /etc/ssh2
		doins ${ROOT}/etc/ssh2/hostkey{,.pub}
		fperms go-rwx /etc/ssh2/hostkey
	fi
	#this is ugly but helps on some problems on fresh installs see bug #57915
	addwrite /root/.ssh2
	make install DESTDIR=${D} || die "install failed"
	chmod 600 ${D}/etc/ssh2/sshd2_config
	dodoc CHANGES FAQ HOWTO.anonymous.sftp README* SSH2.QUICKSTART

	insinto /etc/pam.d
	newins ${FILESDIR}/pamd.sshd2 sshd2
	exeinto /etc/init.d
	newexe ${FILESDIR}/sshd2 sshd2

	cd ${D}/usr
	use openssh && find bin sbin share/man -type l -exec rm '{}' \;
}
