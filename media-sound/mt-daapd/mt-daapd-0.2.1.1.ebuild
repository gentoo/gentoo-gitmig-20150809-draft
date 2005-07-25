# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mt-daapd/mt-daapd-0.2.1.1.ebuild,v 1.4 2005/07/25 13:42:03 dholm Exp $

inherit flag-o-matic eutils

MY_P="${P/_/-}"

DESCRIPTION="A multi-threaded implementation of Apple's DAAP server"
HOMEPAGE="http://mt-daapd.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="debug howl vorbis"

DEPEND="sys-libs/zlib
	media-libs/libid3tag
	sys-libs/gdbm
	debug? ( dev-util/efence )
	howl? ( >=net-misc/howl-0.9.2 )
	vorbis? ( media-libs/libvorbis )"

src_compile() {
	local myconf=""

	# debugging support?
	if use debug; then
		myconf="${myconf} --enable-debug --enable-debug-memory --enable-efence"
	fi

	# howl support?
	if use howl; then
		myconf="--enable-howl --with-howl-libs=/usr/lib --disable-mdns"
		myconf="${myconf} --with-howl-includes=/usr/include/howl/"
	else
		myconf="--disable-howl"
	fi

	econf \
		$(use_enable vorbis oggvorbis) \
		${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc README* NEWS TODO

	insinto /etc/
	doins contrib/mt-daapd.conf
	doins contrib/mt-daapd.playlist

	dodir /usr/share/mt-daapd
	dodir /usr/share/mt-daapd/admin-root

	diropts -m0777
	dodir /var/cache/mt-daapd

	insinto /usr/share/mt-daapd/admin-root
	doins admin-root/*

	newinitd ${FILESDIR}/mt-daapd.init mt-daapd
}

pkg_postinst() {
	if use howl; then
		einfo
		einfo "Since you want to use howl instead of the internal mdnsd"
		einfo "you need to make sure that you have mDNSResponder configured"
		einfo "and running to use mt-daapd."
		einfo
	fi

	if use vorbis; then
		einfo
		einfo "You need to edit you extensions list in /etc/mt-daapd.conf"
		einfo "if you want your mt-daapd to serve ogg files."
		einfo
	fi
}
