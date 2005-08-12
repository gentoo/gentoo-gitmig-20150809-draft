# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libaal/libaal-1.0.5.ebuild,v 1.1 2005/08/12 23:12:49 vapier Exp $

inherit eutils

DESCRIPTION="library required by reiser4progs"
HOMEPAGE="http://www.namesys.com/v4/v4.html"
SRC_URI="ftp://ftp.namesys.com/pub/reiser4progs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 -sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
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
		--libdir=/$(get_libdir) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS CREDITS ChangeLog NEWS README THANKS TODO

	# move silly .a libs out of /
	dodir /usr/$(get_libdir)
	local l=""
	for l in libaal libaal-minimal ; do
		mv ${D}/$(get_libdir)/${l}.{a,la} ${D}/usr/$(get_libdir)/
		dosym /usr/$(get_libdir)/${l}.a /$(get_libdir)/${l}.a
		gen_usr_ldscript ${l}.so
	done
}
