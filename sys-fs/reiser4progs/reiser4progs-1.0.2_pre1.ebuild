# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/reiser4progs/reiser4progs-1.0.2_pre1.ebuild,v 1.1 2004/09/19 21:49:04 vapier Exp $

inherit eutils

MY_P="${PN}-${PV/_/-}"
DATE="2004.09.17"
DESCRIPTION="reiser4progs: mkfs, fsck, etc..."
HOMEPAGE="http://www.namesys.com/v4/v4.html"
SRC_URI="ftp://ftp.namesys.com/pub/reiser4progs/pre/${DATE}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 -sparc"
IUSE="static debug readline"

DEPEND=">=sys-libs/libaal-${PV}
	readline? ( sys-libs/readline )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
		`use_enable static full-static` \
		`use_enable static mkfs-static` \
		`use_enable static fsck-static` \
		`use_enable static debugfs-static` \
		`use_enable static measurefs-static` \
		`use_enable static cpfs-static` \
		`use_enable static resizefs-static` \
		`use_enable debug` \
		`use_with readline` \
		--enable-stand-alone \
		--sbindir=/sbin \
		--libdir=/lib \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS CREDITS ChangeLog NEWS README THANKS TODO

	# move stupid .a out of root
	dodir /usr/lib
	local l=""
	for l in libreiser4-alone libreiser4 librepair ; do
		mv ${D}/lib/${l}.{a,la} ${D}/usr/lib/
		dosym ../usr/lib/${l}.a /lib/${l}.a
		gen_usr_ldscript ${l}.so
	done
}
