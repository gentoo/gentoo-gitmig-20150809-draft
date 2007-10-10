# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ssh/ssh-3.2.9.1-r2.ebuild,v 1.1 2007/10/10 13:51:28 humpback Exp $

inherit eutils pam

DESCRIPTION="SSH.COM free for Non-Commercial Use ssh version"
HOMEPAGE="http://www.ssh.com/"
SRC_URI="ftp://ftp.ssh.com/pub/ssh/${P}.tar.gz"

LICENSE="ssh"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X ipv6 crypt openssh"

RDEPEND="X? ( x11-libs/libSM
			x11-libs/libXext )
	!openssh? ( !virtual/ssh )"
DEPEND="${RDEPEND}
	X? ( x11-proto/xextproto )"
PROVIDE="virtual/ssh"

pkg_setup() {
	enewgroup sshd 22
	enewuser sshd 22 -1 /var/empty sshd
}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/patch-readline.diff
	cd "${S}"
	epatch "${FILESDIR}"/sshfilexfers.diff
}

src_compile() {
	econf \
		$(use_with ipv6 ipv6) \
		$(use_with X) \
		$(use_with crypt gpg) \
		|| die "configure failed"
	make || die "make failed"
}

src_install() {
	# TODO: fix this crap which messes with $ROOT
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

	newpamd "${FILESDIR}"/pamd.sshd2 sshd2
	newinitd "${FILESDIR}"/sshd2 sshd2

	cd "${D}"/usr
	use openssh && find bin sbin share/man -type l -exec rm '{}' \;
}
