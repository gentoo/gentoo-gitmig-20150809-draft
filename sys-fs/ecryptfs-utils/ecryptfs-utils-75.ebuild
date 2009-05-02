# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ecryptfs-utils/ecryptfs-utils-75.ebuild,v 1.1 2009/05/02 18:30:04 arfrever Exp $

EAPI="2"

inherit eutils pam

DESCRIPTION="eCryptfs userspace utilities"
HOMEPAGE="http://launchpad.net/ecryptfs"
SRC_URI="http://launchpad.net/ecryptfs/trunk/${PV}/+download/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gpg gtk nss openssl pam pkcs11 python suid tpm"

RDEPEND=">=sys-apps/keyutils-1.0
	>=dev-libs/libgcrypt-1.2.0
	gpg? ( app-crypt/gpgme )
	gtk? ( x11-libs/gtk+ )
	nss? ( dev-libs/nss )
	openssl? ( >=dev-libs/openssl-0.9.7 )
	pam? ( sys-libs/pam )
	pkcs11? (
		>=dev-libs/openssl-0.9.7
		>=dev-libs/pkcs11-helper-1.04
	)
	python? ( >=dev-lang/python-2.5 )
	tpm? ( app-crypt/trousers )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	python? ( dev-lang/swig )"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix_warnings.patch"
}

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--with-pamdir=$(getpam_mod_dir) \
		$(use_enable doc docs) \
		$(use_enable gpg) \
		$(use_enable gtk gui) \
		$(use_enable nss) \
		$(use_enable openssl) \
		$(use_enable pam) \
		$(use_enable pkcs11 pkcs11-helper) \
		$(use_enable python pywrap) \
		$(use_enable tpm tspi)
}

src_install(){
	emake DESTDIR="${D}" install || die "emake install failed"
	use suid && fperms u+s /sbin/mount.ecryptfs
}

pkg_postinst() {
	if use suid; then
		ewarn
		ewarn "You have chosen to install ${PN} with the binary setuid root. This"
		ewarn "means that if there are any undetected vulnerabilities in the binary,"
		ewarn "then local users may be able to gain root access on your machine."
		ewarn
	fi
}
