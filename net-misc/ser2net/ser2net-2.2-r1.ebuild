# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ser2net/ser2net-2.2-r1.ebuild,v 1.2 2005/03/20 18:57:59 weeve Exp $

inherit eutils

DESCRIPTION="Serial To Network Proxy"
SRC_URI="mirror://sourceforge/ser2net/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/ser2net"

KEYWORDS="~x86 ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )"

IUSE="tcpd"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-tcpwrappers-configure.in.patch || \
	    die "patch failed"
}

src_compile() {
	ebegin "Recreating configure"
	autoconf || die "Error: autoconf failed"
	eend $?

	ebegin "Recreating Makefile"
	automake || die "Error: automake failed"
	eend $?

	econf $(use_with tcpd tcp-wrappers) || die "Error: econf failed"
	libtoolize --copy --force
	emake || die "Error: emake failed"
}

src_install () {
	einstall
	insinto /etc
	doins ser2net.conf
	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
}
