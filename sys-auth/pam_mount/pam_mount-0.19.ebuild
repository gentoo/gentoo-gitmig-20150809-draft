# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_mount/pam_mount-0.19.ebuild,v 1.3 2007/08/14 15:49:42 strerror Exp $

inherit eutils multilib

DESCRIPTION="A PAM module that can mount volumes for a user session"
HOMEPAGE="http://pam-mount.sourceforge.net"
SRC_URI="mirror://sourceforge/pam-mount/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="crypt"
DEPEND=">=sys-libs/pam-0.72
	dev-libs/openssl
	>=dev-libs/glib-2.0.0
	sys-libs/libhx"
RDEPEND="$DEPEND
	crypt? ( || ( >=sys-fs/cryptsetup-1.0.5 sys-fs/cryptsetup-luks ) )
	sys-process/lsof"

src_compile() {
	econf --with-slibdir="/$(get_libdir)" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	insinto /etc/security
	doins ${S}/config/pam_mount.conf.xml || die

	dodoc README TODO AUTHORS FAQ || die
}
