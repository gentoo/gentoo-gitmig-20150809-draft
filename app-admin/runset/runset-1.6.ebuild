# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/runset/runset-1.6.ebuild,v 1.4 2004/10/05 02:58:11 pvdabeel Exp $

DESCRIPTION="Runset Init suite, a replacement for sysv style initd"
HOMEPAGE="http://www.icewalkers.com/softlib/app/app_00233.html"
SRC_URI="ftp://ftp.ocis.net/pub/users/ldeutsch/release/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s/\(int planned_shutdown;\)/volatile \1/" runset/common.h
}

src_install() {
	# fix info file
	cat << EOF >> doc/runset.info
INFO-DIR-SECTION Admin
START-INFO-DIR-ENTRY
* runset: (runset).
END-INFO-DIR-ENTRY
EOF
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog LSM NEWS README
	cp -a ${S}/sample ${D}/usr/share/doc/${PF}/
}
