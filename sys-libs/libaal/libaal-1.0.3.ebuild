# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libaal/libaal-1.0.3.ebuild,v 1.2 2005/05/22 06:44:16 vapier Exp $

inherit eutils

DESCRIPTION="library required by reiser4progs"
HOMEPAGE="http://www.namesys.com/v4/v4.html"
SRC_URI="ftp://ftp.namesys.com/pub/reiser4progs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	# remove stupid CFLAG hardcodes
	sed -i \
		-e "/GENERIC_CFLAGS/s:-O3::" \
		-e "/^CFLAGS=/s:\"\":\"${CFLAGS}\":" \
		configure || die "sed"
	cat << EOF > run-ldconfig
#!/bin/sh
true
EOF
}

src_compile() {
	econf \
		--enable-libminimal \
		--enable-memory-manager \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS CREDITS ChangeLog NEWS README THANKS TODO

	# move .so into / (need for fsck)
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/libaal*.so* "${D}"/$(get_libdir)/
	gen_usr_ldscript libaal.so
	gen_usr_ldscript libaal-minimal.so
}
