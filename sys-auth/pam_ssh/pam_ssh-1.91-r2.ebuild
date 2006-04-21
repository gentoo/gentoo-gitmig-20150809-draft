# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_ssh/pam_ssh-1.91-r2.ebuild,v 1.1 2006/04/21 11:41:25 flameeyes Exp $

inherit pam eutils

DESCRIPTION="Uses ssh-agent to provide single sign-on"
HOMEPAGE="http://pam-ssh.sourceforge.net/"
SRC_URI="mirror://sourceforge/pam-ssh/${P}.tar.bz2"

RESTRICT="nomirror confcache"
LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

# Doesn't work on OpenPAM.
DEPEND="sys-libs/pam
	sys-devel/libtool"

RDEPEND="sys-libs/pam
	virtual/ssh"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-debian.patch" #105546
	epatch "${FILESDIR}/${P}-syslog.patch" # glibc-2.4
}

src_compile() {
	econf \
		"--with-pam-dir=$(getpam_mod_dir)" \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO "${FILESDIR}/system-auth.example"
}

pkg_postinst() {
	einfo "You can find an example system-auth file that uses this"
	einfo "library in /usr/share/doc/${PF}"
}
