# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_ssh_agent/pam_ssh_agent-0.1.ebuild,v 1.1 2005/07/02 15:11:52 flameeyes Exp $

inherit toolchain-funcs

DESCRIPTION="PAM module that spawns a ssh-agent and adds identities using the password supplied at login"
HOMEPAGE="http://pam-ssh-agent.sourceforge.net/"
SRC_URI="mirror://sourceforge/pam-ssh-agent/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND="sys-libs/pam
	>=sys-apps/sed-4"
RDEPEND="net-misc/keychain
	dev-tcltk/expect"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:gcc:$(tc-getCC) ${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc LICENSE README
}
