# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/bobotpp/bobotpp-2.1.5.ebuild,v 1.1 2005/01/24 14:13:00 swegener Exp $

DESCRIPTION="A flexible IRC bot scriptable in scheme"
HOMEPAGE="http://unknownlamer.org/code/bobot.html"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="guile"

DEPEND="guile? ( dev-util/guile )"

src_compile() {
	econf $(use_enable guile scripting) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	dosym bobot++.info /usr/share/info/bobotpp.info || die "dosym failed"

	dodoc AUTHORS ChangeLog NEWS README SCRIPTING TODO || die "dodoc failed"
	dohtml doc/index.html || die "dohtml failed"

	docinto example-config
	dodoc examples/{bot.*,scripts.load} || die "dodoc failed"

	docinto example-scripts
	dodoc scripts/{boulet,country,eval,hello,log.scm,tamere,uname,uptime} || die "dodoc failed"
}

pkg_postinst() {
	einfo
	einfo "You can find a sample configuration file set in"
	einfo "/usr/share/doc/${PF}/example-config"
	einfo
}
