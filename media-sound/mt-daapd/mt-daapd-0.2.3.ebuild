# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mt-daapd/mt-daapd-0.2.3.ebuild,v 1.1 2005/10/03 16:08:13 matsuu Exp $

inherit flag-o-matic eutils

MY_P="${P/_/-}"

DESCRIPTION="A multi-threaded implementation of Apple's DAAP server"
HOMEPAGE="http://www.mt-daapd.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug howl vorbis"

DEPEND="sys-libs/zlib
	media-libs/libid3tag
	sys-libs/gdbm
	debug? ( dev-util/efence )
	howl? ( >=net-misc/howl-0.9.2 )
	vorbis? ( media-libs/libvorbis )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:/usr/local:/usr:' contrib/mt-daapd-gentoo || die
}

src_compile() {
	local myconf=""

	# debugging support?
	if use debug; then
		myconf="${myconf} --enable-debug --enable-debug-memory --enable-efence"
	fi

	# howl support?
	if use howl; then
		myconf="${myconf} --enable-howl"
		myconf="${myconf} --with-howl-libs=/usr/$(get_libdir)"
		myconf="${myconf} --with-howl-includes=/usr/include/howl"
	fi

	# Bug 65723
	if use vorbis; then
		myconf="${myconf} --enable-oggvorbis"
	fi

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	insinto /etc
	doins contrib/mt-daapd.conf
	doins contrib/mt-daapd.playlist

	newinitd contrib/mt-daapd-gentoo mt-daapd

	keepdir /var/cache/mt-daapd

	dodoc AUTHORS CREDITS ChangeLog INSTALL NEWS README TODO
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
