# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ecryptfs-utils/ecryptfs-utils-32.ebuild,v 1.1 2007/12/13 18:45:03 alonbl Exp $

inherit autotools

DESCRIPTION="eCryptfs userspace utilities"
HOMEPAGE="http://www.ecryptfs.org"
SRC_URI="mirror://sourceforge/ecryptfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="suid pam gtk openssl pkcs11 gpg doc"

RDEPEND="sys-apps/keyutils
	dev-libs/libgcrypt
	pam? ( sys-libs/pam )
	openssl? ( dev-libs/openssl )
	pkcs11? (
		dev-libs/openssl
		>=dev-libs/pkcs11-helper-1.04
	)
	gpg? ( app-crypt/gpgme )
	gtk? ( x11-libs/gtk+ )"
# perl required for man generation
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-lang/perl"

src_compile() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		$(use_enable pam) \
		$(use_enable openssl) \
		$(use_enable pkcs11 pkcs11-helper) \
		$(use_enable gpg) \
		$(use_enable gtk gui) \
		$(use_enable doc docs) \
		|| die
	emake || die
}

src_install(){
	emake DESTDIR="${D}" install || die
	use suid && fperms u+s /sbin/mount.ecryptfs
}

pkg_postinst() {
	if use suid; then
		ewarn
		ewarn "You have chosen to install ${PN} with the binary setuid root. This"
		ewarn "means that if there any undetected vulnerabilities in the binary,"
		ewarn "then local users may be able to gain root access on your machine."
		ewarn
	fi
}
