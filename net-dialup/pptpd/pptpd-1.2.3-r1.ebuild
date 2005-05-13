# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpd/pptpd-1.2.3-r1.ebuild,v 1.3 2005/05/13 04:12:41 mrness Exp $

DESCRIPTION="Linux Point-to-Point Tunnelling Protocol Server"
SRC_URI="mirror://sourceforge/poptop/${P}.tar.gz"
HOMEPAGE="http://www.poptop.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE="tcpd"

DEPEND="virtual/libc
	net-dialup/ppp
	tcpd? ( sys-apps/tcp-wrappers )"

src_unpack() {
	unpack ${A}

	#Match pptpd-logwtmp.so's version with pppd's version (#89895)
	local PPPD_VER=`best_version net-dialup/ppp`
	PPPD_VER=${PPPD_VER#*/*-} #reduce it to ${PV}-${PR}
	PPPD_VER=${PPPD_VER%%[_-]*} # main version without beta/pre/patch/revision
	sed -i -e "s:\\(#define[ \\t]*VERSION[ \\t]*\\)\".*\":\\1\"${PPPD_VER}\":" ${S}/plugins/patchlevel.h
}

src_compile() {
	local myconf
	use tcpd && myconf="--with-libwrap"
	econf 	--with-bcrelay \
		${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install () {
	einstall || die "make install failed"

	insinto /etc
	doins samples/pptpd.conf

	insinto /etc/ppp
	doins samples/options.pptpd

	exeinto /etc/init.d
	newexe ${FILESDIR}/pptpd-init pptpd

	insinto /etc/conf.d
	newins ${FILESDIR}/pptpd-confd pptpd

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README* TODO
	docinto samples
	dodoc samples/*
}
