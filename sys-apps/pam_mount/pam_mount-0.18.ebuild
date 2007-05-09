# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pam_mount/pam_mount-0.18.ebuild,v 1.2 2007/05/09 04:37:59 hanno Exp $

inherit eutils

DESCRIPTION="A PAM module that can mount volumes for a user session"
HOMEPAGE="http://pam-mount.sourceforge.net"
SRC_URI="mirror://sourceforge/pam-mount/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="crypt"
DEPEND=">=sys-libs/pam-0.72
	dev-libs/openssl
	>=dev-libs/glib-2.0.0"
RDEPEND="$DEPEND
	crypt? ( sys-fs/cryptsetup-luks )
	sys-process/lsof"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	epatch "${FILESDIR}"/pam_mount-cryptsetup-path.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	insinto /etc/security
	doins ${S}/config/pam_mount.conf
	dosbin scripts/mount.crypt scripts/umount.crypt

	dodoc README TODO AUTHORS ChangeLog FAQ NEWS || die
}
