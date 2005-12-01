# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mt-daapd/mt-daapd-0.2.3-r1.ebuild,v 1.2 2005/12/01 09:25:38 vapier Exp $

inherit flag-o-matic eutils

MY_P="${P/_/-}"

DESCRIPTION="A multi-threaded implementation of Apple's DAAP server"
HOMEPAGE="http://www.mt-daapd.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~sh ~x86"
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
	epatch ${FILESDIR}/${P}-pidfile.patch
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

	cp ${FILESDIR}/${PN}.init.2 ${WORKDIR}/initd
	use howl && \
		sed -i -e 's:#USEHOWL ::' ${WORKDIR}/initd || \
		sed -i -e '/#USEHOWL/d' ${WORKDIR}/initd
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	insinto /etc
	newins contrib/mt-daapd.conf mt-daapd.conf.example
	doins contrib/mt-daapd.playlist

	newinitd ${WORKDIR}/initd ${PN}

	keepdir /var/cache/mt-daapd /etc/mt-daapd.d

	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO
}

pkg_postinst() {
	einfo
	einfo "You have to configure your mt-daapd.conf following"
	einfo "/etc/mt-daapd.conf.example file."
	einfo

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

	einfo
	einfo "If you want to start more than one ${PN} service, symlink"
	einfo "/etc/init.d/${PN} to /etc/init.d/${PN}.<name>, and it will"
	einfo "load the data from /etc/${PN}.d/<name>.conf."
	einfo "Make sure that you have different cache directories for them."
	einfo
}
