# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/netatalk/netatalk-1.6.4-r1.ebuild,v 1.5 2004/10/25 12:04:28 klieber Exp $

inherit eutils
IUSE="ssl pam tcpd"

DESCRIPTION="kernel level implementation of the AppleTalk Protocol Suite"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://netatalk.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ppc64"

DEPEND="sys-apps/shadow
	pam? ( sys-libs/pam )
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.6.4-tempfile.patch
}

src_compile() {
	use pam  && myconf="${myconf} --with-pam"
	use tcpd && myconf="${myconf} --with-tcp-wrappers"
	use ssl  && myconf="${myconf} --disable-ssl"

	econf \
		--enable-fhs \
		--with-shadow \
		--with-bdb=/usr \
		${myconf} || die "netatalk configure failed"

	emake || die "netatalk emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "netatalk make install failed"

	# install docs
	dodoc CHANGES CONTRIBUTORS COPYING COPYRIGHT ChangeLog
	dodoc NEWS README TODO VERSION
	dodoc doc/*

	# install init script
	exeinto /etc/init.d
	newexe ${FILESDIR}/atalknew-rc6 atalk
}
