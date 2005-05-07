# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/siproxd/siproxd-0.5.11.ebuild,v 1.1 2005/05/07 15:36:23 stkn Exp $

inherit eutils

IUSE="static doc"

DESCRIPTION="masquerading SIP proxy"
HOMEPAGE="http://siproxd.sourceforge.net/"
SRC_URI="mirror://sourceforge/siproxd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=net-libs/libosip-2.0.0
	doc? ( app-text/docbook-sgml-utils )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-configure-docs.diff

	# re-create configure (stolen from dhcpd :)
	einfo "Re-creating configure..."
	autoreconf -fi || die "autoreconf failed"
}

src_compile() {
	local myconf

	use static && \
		myconf="--enable-static"

	econf ${myconf} \
		`use_enable doc docs` || die "configure failed"

	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"

	exeinto /etc/init.d
	newexe ${FILESDIR}/siproxd.rc6 siproxd

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO RELNOTES
}
