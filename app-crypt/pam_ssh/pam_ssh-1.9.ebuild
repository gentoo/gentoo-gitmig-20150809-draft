# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pam_ssh/pam_ssh-1.9.ebuild,v 1.3 2004/03/30 00:56:25 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Uses ssh-agent to provide single sign-on"
HOMEPAGE="http://pam-ssh.sourceforge.net/"
SRC_URI="mirror://sourceforge/pam-ssh/${P}.tar.bz2"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}
	virtual/ssh"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-standard-prompt.patch
}

src_install() {
	make install DESTDIR=${D} || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO ${FILESDIR}/system-auth.example
}

pkg_postinst() {
	einfo "You can find an example system-auth file that uses this"
	einfo "library in /usr/share/doc/${PF}"
}
