# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-fs/netatalk/netatalk-1.5.3.1.ebuild,v 1.3 2002/07/25 05:00:38 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="kernel level implementation of the AppleTalk Protocol Suite"
SRC_URI="mirror://sourceforge/netatalk/${P}.tar.gz"
HOMEPAGE="http://netatalk.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="sys-apps/shadow
	>=sys-libs/db-3
	pam? ( sys-libs/pam )
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )"

src_compile() {
	use pam  && myconf="${myconf} --with-pam"
	use tcpd && myconf="${myconf} --with-tcp-wrappers"
	use ssl  || myconf="${myconf} --disable-ssl"

	econf \
		--enable-fhs \
		--with-shadow \
		--with-db3 \
		${myconf} || die "netatalk configure failed"

	emake || die "netatalk emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "netatalk make install failed"

	# install docs
	dodoc BUGS CHANGES CONTRIBUTORS COPYING COPYRIGHT ChangeLog
	dodoc NEWS README TODO VERSION

	# install init script
	mkdir -p ${D}/etc/init.d
	cp ${FILESDIR}/atalk-rc6 ${D}/etc/init.d/atalk
	chmod 755 ${D}/etc/init.d/atalk
}
