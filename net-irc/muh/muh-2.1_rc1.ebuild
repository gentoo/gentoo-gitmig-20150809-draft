# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/muh/muh-2.1_rc1.ebuild,v 1.8 2004/08/08 00:09:39 slarti Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Persistent IRC bouncer"
HOMEPAGE="http://mind.riot.org/muh/"
IUSE=""

SRC_URI="mirror://sourceforge/muh/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha ~hppa ~mips"

src_compile() {
	econf || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	einstall install || die "install failed"
	dodoc AUTHORS COPYING INSTALL ChangeLog
}

pkg_postinst() {
	einfo
	einfo "You'll need to configure muh before running it"
	einfo "Put your config in ~/.muh/muhrc"
	einfo "A sample config is /usr/share/muhrc"
	einfo "For more information, see the documentation"
	einfo
}
