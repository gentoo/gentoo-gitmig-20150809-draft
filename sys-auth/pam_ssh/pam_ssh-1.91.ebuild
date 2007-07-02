# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_ssh/pam_ssh-1.91.ebuild,v 1.3 2007/07/02 15:28:49 peper Exp $

DESCRIPTION="Uses ssh-agent to provide single sign-on"
HOMEPAGE="http://pam-ssh.sourceforge.net/"
SRC_URI="mirror://sourceforge/pam-ssh/${P}.tar.bz2"
RESTRICT="mirror"
LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="sys-libs/pam
	sys-apps/gawk
	sys-apps/grep
	sys-devel/libtool"

RDEPEND="sys-libs/pam
	virtual/ssh"

src_install() {
	make install DESTDIR=${D} || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO ${FILESDIR}/system-auth.example
}

pkg_postinst() {
	einfo "You can find an example system-auth file that uses this"
	einfo "library in /usr/share/doc/${PF}"
}
