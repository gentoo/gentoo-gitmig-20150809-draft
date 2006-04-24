# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/mcabber/mcabber-0.7.6.ebuild,v 1.1 2006/04/24 18:50:57 reb Exp $

DESCRIPTION="A small Jabber console client that includes features such as SSL
support, MUC (Multi-User Chat) support, history logging, commands completion,
and external actions triggers."

HOMEPAGE="http://www.lilotux.net/~mikael/mcabber/"

SRC_URI="http://www.lilotux.net/~mikael/mcabber/files/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc ~alpha ~mips ~sparc ~amd64"

IUSE="ssl"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.7-r1 )
	>=dev-libs/glib-2.0.0"

src_compile() {
	econf \
		$(use_with ssl) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc ${S}/mcabberrc.example
}

pkg_postinst() {
	einfo "MCabber requires you to create a configuration file in your home directory."
	einfo "A template of such file was installed as part of the documentation for this software."
	einfo "This file is intended to be self-documenting."
	einfo "See the CONFIGURATION FILE and FILES sections of mcabber(1) for more information."
}
