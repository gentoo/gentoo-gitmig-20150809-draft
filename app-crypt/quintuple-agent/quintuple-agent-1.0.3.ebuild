# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/quintuple-agent/quintuple-agent-1.0.3.ebuild,v 1.3 2003/06/29 22:18:39 aliz Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Quintuple Agent stores your (GnuPG) secrets in a secure manner."
HOMEPAGE="http://www.vibe.at/tools/secret-agent/"
SRC_URI="http://www.vibe.at/tools/secret-agent/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="nls"

DEPEND="app-crypt/gnupg
	>=dev-libs/glib-1.2.0
	>=x11-libs/gtk+-1.2.0
	nls? ( sys-devel/gettext )"

src_compile() {
	econf $(use_enable nls)
	emake
}

src_install () {
	einstall
	chmod +s "${D}/usr/bin/q-agent"
	
	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README THANKS TODO
	docinto doc
	dodoc doc/*.sgml
}

pkg_postinst() {
	einfo "q-agent is installed SUID root to make use of protected memory space"
	einfo "This is needed in order to have a secure place to store your passphrases,"
	einfo "etc. at runtime but may make some sysadmins nervous"
}
