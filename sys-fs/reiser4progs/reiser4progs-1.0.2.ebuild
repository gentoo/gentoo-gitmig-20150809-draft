# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/reiser4progs/reiser4progs-1.0.2.ebuild,v 1.2 2004/10/31 19:25:26 vapier Exp $

inherit eutils

DESCRIPTION="reiser4progs: mkfs, fsck, etc..."
HOMEPAGE="http://www.namesys.com/v4/v4.html"
SRC_URI="ftp://ftp.namesys.com/pub/reiser4progs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 -sparc"
IUSE="static debug readline"

DEPEND=">=sys-libs/libaal-${PV}
	readline? ( sys-libs/readline )"

src_unpack() {
	unpack ${A}
	cd ${S}
	cat << EOF > run-ldconfig
#!/bin/sh
true
EOF
}

src_compile() {
	econf \
		$(use_enable static full-static) \
		$(use_enable static mkfs-static) \
		$(use_enable static fsck-static) \
		$(use_enable static debugfs-static) \
		$(use_enable static measurefs-static) \
		$(use_enable static cpfs-static) \
		$(use_enable static resizefs-static) \
		$(use_enable debug) \
		$(use_with readline) \
		--enable-libminimal \
		--sbindir=/sbin \
		--libdir=/$(get_libdir) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS CREDITS ChangeLog NEWS README THANKS TODO

	# move stupid .a out of root
	dodir /usr/$(get_libdir)
	local l=""
	for l in libreiser4-minimal libreiser4 librepair ; do
		mv ${D}/$(get_libdir)/${l}.{a,la} ${D}/usr/$(get_libdir)/
		dosym ../usr/lib/${l}.a /lib/${l}.a
		gen_usr_ldscript ${l}.so
	done
}
