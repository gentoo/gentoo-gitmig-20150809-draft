# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/lsh/lsh-1.4.3-r1.ebuild,v 1.4 2004/11/22 04:45:01 vapier Exp $

inherit eutils

DESCRIPTION="A GNU implementation of the Secure Shell protocols"
HOMEPAGE="http://www.lysator.liu.se/~nisse/lsh/"
SRC_URI="ftp://ftp.lysator.liu.se/pub/security/lsh/${P}.tar.gz
	http://www.lysator.liu.se/~nisse/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE="pam tcpd ipv6 zlib X"

DEPEND="dev-libs/gmp
	dev-libs/liboop
	zlib? ( sys-libs/zlib )
	X? ( virtual/x11 )
	tcpd? ( sys-apps/tcp-wrappers )
	pam? ( sys-libs/pam )"
#	kerberos? ( virtual/krb5 )

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc34.patch
	epatch ${FILESDIR}/${PV}-configure.patch
	autoconf || die
}

src_compile() {
	# configure script checks /dev/ptmx in order to enable
	# proper unix pty support ... so lets fake that it works :)
	addpredict /dev/ptmx
#		$(use_enable kerberos)
	econf \
		--disable-kerberos \
		$(use_enable pam) \
		$(use_enable ipv6) \
		$(use_with zlib) \
		$(use_with tcpd tcpwrappers) \
		$(use_with X x) \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc ANNOUNCE AUTHORS ChangeLog FAQ NEWS README

	# remove bundled crap #56156
	cd ${D}/usr
	rm -rf lib include share/info/nettle.info*
}
