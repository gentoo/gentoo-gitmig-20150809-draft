# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sysfsutils/sysfsutils-1.2.0-r3.ebuild,v 1.2 2005/08/08 13:42:56 flameeyes Exp $

inherit eutils libtool

DESCRIPTION="System Utilities Based on Sysfs"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"
SRC_URI="mirror://sourceforge/linux-diag/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ia64 ~mips ~ppc ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-write-attribute.patch
}

src_compile() {
	econf --libdir=/$(get_libdir) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	# We do not distribute this
	rm -f "${D}"/usr/bin/dlist_test

	# Move static libs to /usr/lib - no reason to have then in /lib
	dodir /usr/$(get_libdir)
	mv -f "${D}"/$(get_libdir)/*.a  "${D}"/usr/$(get_libdir)/
	dosym ../../$(get_libdir)/libsysfs.la /usr/$(get_libdir)/libsysfs.la
	# We need a linker script in /usr/lib, else all apps just links against
	# the static library .. bug #4411
	gen_usr_ldscript libsysfs.so

	dodoc AUTHORS ChangeLog NEWS README TODO docs/libsysfs.txt
}
