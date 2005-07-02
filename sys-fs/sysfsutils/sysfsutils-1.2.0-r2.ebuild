# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sysfsutils/sysfsutils-1.2.0-r2.ebuild,v 1.1 2005/07/02 19:02:27 robbat2 Exp $

inherit eutils libtool

DESCRIPTION="System Utilities Based on Sysfs"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"
SRC_URI="mirror://sourceforge/linux-diag/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-write-attribute.patch
}

src_compile() {
	econf --libdir=/lib || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	# We do not distribute this
	rm -f "${D}"/usr/bin/dlist_test
	dodoc AUTHORS ChangeLog NEWS README TODO docs/libsysfs.txt
	dodir /usr/$(get_libdir)
	mv ${D}/$(get_libdir)/*a  ${D}/usr/$(get_libdir)
	dosym /usr/$(get_libdir)/libsysfs.la /$(get_libdir)/libsysfs.la
}
