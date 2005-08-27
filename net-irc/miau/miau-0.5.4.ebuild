# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/miau/miau-0.5.4.ebuild,v 1.3 2005/08/27 02:30:21 swegener Exp $

DESCRIPTION="Persistent IRC bouncer with multi-client support - a fork of muh"
HOMEPAGE="http://miau.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="debug ipv6"

DEPEND=""

src_compile() {
	econf \
		--enable-dccbounce \
		--enable-automode \
		--enable-releasenick \
		--enable-ctcp-replies \
		--enable-mkpasswd \
		--enable-uptime \
		--enable-chanlog \
		--enable-privlog \
		--enable-onconnect \
		--enable-empty-awaymsg \
		$(use_enable ipv6) \
		$(use_enable debug) \
		$(use_enable debug enduserdebug) \
		$(use_enable debug pingstat) \
		$(use_enable debug dumpstatus) \
		|| die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog TODO README || die "dodoc failed"

	mv "${D}"/usr/share/doc/miau/examples/miaurc "${D}"/usr/share/doc/${PF}/miaurc.sample
	rm -rf "${D}"/usr/share/doc/miau
}

pkg_postinst() {
	einfo
	einfo "You'll need to configure miau before running it."
	einfo "Put your config in ~/.miau/miaurc"
	einfo "A sample config is /usr/share/doc/${PF}/miaurc.sample"
	einfo "For more information, see the documentation."
	einfo
}
