# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ecryptfs-utils/ecryptfs-utils-30.ebuild,v 1.4 2007/12/04 11:09:37 alonbl Exp $

inherit autotools

DESCRIPTION="eCryptfs userspace utilities"
HOMEPAGE="http://www.ecryptfs.org"
SRC_URI="mirror://sourceforge/ecryptfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="pam gtk openssl pkcs11 gpg doc"

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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gpgme.patch"
	epatch "${FILESDIR}/${P}-gtk.patch"
	# Until upstream move to autoconf-2.60
	eautoreconf
}

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
	fperms u+s /sbin/mount.ecryptfs
}
