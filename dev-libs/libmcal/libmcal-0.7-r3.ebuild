# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcal/libmcal-0.7-r3.ebuild,v 1.5 2004/10/19 08:28:11 absinthe Exp $

inherit eutils

DRIVERS="mcaldrivers-0.9"
SRC_URI_BASE="mirror://sourceforge/libmcal"
DESCRIPTION="Modular Calendar Access Library"
HOMEPAGE="http://mcal.chek.com/"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz ${SRC_URI_BASE}/${DRIVERS}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips alpha arm hppa amd64 ~ia64 ~s390"
IUSE="pam"

DEPEND="pam? ( sys-libs/pam )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	mv ${S}/../mcal-drivers/* ${S}/
	einfo "Using /var/spool/calendar instead of /var/calendar"
	for i in FAQ-MCAL HOW-TO-MCAL mstore/mstore.c mstore/README mstore/Changelog; do
		sed -e 's|/var/calendar|/var/spool/calendar|g' -i ${i}
	done
	cd ${S}
	epatch ${FILESDIR}/${P}-fpic.patch
}

src_compile() {
	use pam && CFLAGS="${CFLAGS} -DUSE_PAM -lpam" LDFLAGS="${LDFLAGS} -lpam"
	einfo "Setting up mstore back-end"
	cd ${S}/mstore
	emake CFLAGS="${CFLAGS} -I.." LDFLAGS="${LDFLAGS}" || die

	einfo "Setting up icap back-end"
	cd ${S}/icap
	emake CFLAGS="${CFLAGS} -I.." LDFLAGS="${LDFLAGS}" || die

	cd ${S}
	myconf="--with-mstore --with-icap"
	econf ${myconf} || die
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc CHANGELOG FAQ-MCAL FEATURE-IMPLEMENTATION HOW-TO-MCAL LICENSE README
	newdoc mstore/README mstore-README
	newdoc mstore/Changelog mstore-Changelog
	newdoc icap/Changelog icap-Changelog
	dohtml FUNCTION-REF.html
	keepdir /var/spool/calendar
	fperms 1777 /var/spool/calendar
}

pkg_postinst() {
	einfo "You should start adding users to your calendar. ( e.g. htpasswd -c /etc/mpasswd username )"
	# enforce perms
	chmod 1777 ${ROOT}/var/spool/calendar
}
