# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-3.4_p1.ebuild,v 1.1 2002/06/26 18:09:43 lostlogic Exp $

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

LICENSE="as-is"
SLOT="0"

pkg_setup() {
	if ! groupmod sshd; then
		groupadd -g 90 sshd || die "problem adding group sshd"
	fi

	if ! id sshd; then
		useradd -g sshd -s /dev/null -d /var/empty -c "sshd" sshd
		assert "problem adding user sshd"
	fi
}

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

pkg_postinst() {
	# empty dir for the new priv separation auth chroot..
	install -d -m0755 -o root -g root ${ROOT}/var/empty

	einfo
	einfo "Remember to merge your config files in /etc/ssh!"
	einfo "As of version 3.4 the default is to enable the UsePrivelegeSeparation"
	einfo "functionality, but please ensure that you do not explicitly disable"
	einfo "this in your configuration as disabling it opens security holes"
	einfo
}
