# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.10.1.ebuild,v 1.12 2006/10/20 00:30:30 kloeri Exp $

inherit eutils libtool

DESCRIPTION="SmartCard library and applications"
HOMEPAGE="http://www.opensc.org/"
SRC_URI="http://www.opensc-project.org/files/opensc/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86"
IUSE="ldap pcsc-lite X"
#pam

RDEPEND="X? ( || ( ( >=x11-libs/libX11-1.0.0 >=x11-libs/libXt-1.0.0 ) virtual/x11 ) )
	ldap? ( net-nds/openldap )
	pcsc-lite? ( sys-apps/pcsc-lite )
	!pcsc-lite? ( >=dev-libs/openct-0.5.0 )"

#PDEPEND="pam? ( dev-libs/pam_pkcs11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use X || echo 'all:'$'\n''install:' > src/signer/Makefile.in
	EPATCH_SINGLE_MSG="Applying libtool reverse deps patch ..." \
		epatch ${ELT_PATCH_DIR}/fix-relink/1.5.0
}

src_compile() {
	local mycard=""
	use pcsc-lite \
		&& mycard="--with-pcsclite" \
		|| mycard="--with-openct=/usr"
	# --without-plugin-dir generates a /no directory
	econf \
		--disable-usbtoken \
		--with-plugin-dir=/usr/lib/mozilla/plugins \
		$(use_enable ldap) \
		${mycard} \
		|| die

	emake -j1 || die
}

src_install() {
	make install DESTDIR="${D}" || die

	dodoc NEWS README
	dohtml docs/opensc.{html,css}
}

pkg_postinst() {
	ewarn "If you are upgrading, please remember to run"
	ewarn "revdep-rebuild due to ABI breakage."
}
