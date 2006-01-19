# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.10.0.ebuild,v 1.4 2006/01/19 02:49:25 vanquirius Exp $

inherit eutils libtool

DESCRIPTION="SmartCard library and applications"
HOMEPAGE="http://www.opensc.org/"
SRC_URI="http://www.opensc.org/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="ldap pam pcsc-lite X"

DEPEND="X? ( || (
	( >=x11-libs/libX11-1.0.0
	>=x11-libs/libXt-1.0.0 )
	virtual/x11 ) )"

RDEPEND="${DEPEND}
	ldap? ( net-nds/openldap )
	pam? ( >=sys-libs/pam-0.77
		>=sys-apps/shadow-4.0.3 )
	pcsc-lite? ( sys-apps/pcsc-lite )
	!pcsc-lite? ( >=dev-libs/openct-0.5.0 )"

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
		$(use_with pam) \
		${mycard} \
		|| die

	emake -j1 || die
}

src_install() {
	make install DESTDIR="${D}" || die

	if use pam ; then
		dodir /lib/security/
		dosym ../../usr/lib/security/pam_opensc.so /lib/security/
	fi

	dodoc NEWS README
	dohtml docs/opensc.{html,css}
}
