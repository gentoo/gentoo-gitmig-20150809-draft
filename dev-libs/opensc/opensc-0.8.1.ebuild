# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.8.1.ebuild,v 1.4 2004/03/21 06:37:04 mr_bones_ Exp $

DESCRIPTION="SmartCard library and applications"
HOMEPAGE="http://www.opensc.org/"
SRC_URI="http://www.opensc.org/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="ldap pam pcsc-lite"

RDEPEND="ldap? ( net-nds/openldap )
	pam? ( >=sys-libs/pam-0.77
		>=sys-apps/shadow-4.0.3 )
	pcsc-lite? ( sys-apps/pcsc-lite )
	!pcsc-lite? ( >=dev-libs/openct-0.5.0 )"

src_compile() {
	local mycard=""
	use pcsc-lite \
		&& mycard="--with-pcsclite" \
		|| mycard="--with-openct=/usr"
	econf \
		--disable-usbtoken \
		--without-plugin-dir \
		`use_enable ldap` \
		`use_with pam` \
		${mycard} \
		|| die
	emake -j1 || die
}

src_install() {
	make install DESTDIR=${D} || die

	if use pam ; then
		dodir /lib/security/
		dosym ../../usr/lib/security/pam_opensc.so /lib/security/
	fi

	dodoc ANNOUNCE AUTHORS ChangeLog NEWS README
	dohtml docs/opensc.html docs/opensc.css
}
