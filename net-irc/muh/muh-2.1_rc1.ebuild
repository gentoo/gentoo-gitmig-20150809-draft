# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/muh/muh-2.1_rc1.ebuild,v 1.1 2003/09/30 19:14:16 hhg Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Persistant IRC bouncer"
HOMEPAGE="http://mind.riot.org/muh/"
IUSE=""

SRC_URI="mirror://sourceforge/muh/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

src_compile() {
	econf || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	einstall install || die "install failed"
	dodoc AUTHORS COPYING INSTALL ChangeLog
}
