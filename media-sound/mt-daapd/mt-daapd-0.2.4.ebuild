# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mt-daapd/mt-daapd-0.2.4.ebuild,v 1.2 2006/04/11 20:53:21 gustavoz Exp $

inherit eutils autotools

MY_P="${P/_/-}"

DESCRIPTION="A multi-threaded implementation of Apple's DAAP server"
HOMEPAGE="http://www.mt-daapd.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~sh sparc ~x86"
IUSE="howl vorbis avahi"

DEPEND="sys-libs/zlib
	media-libs/libid3tag
	sys-libs/gdbm
	howl? ( !avahi? ( >=net-misc/howl-0.9.2 )
		avahi? ( net-dns/avahi ) )
	vorbis? ( media-libs/libvorbis )"

pkg_setup() {
	if use howl && use avahi && ! built_with_use net-dns/avahi howl-compat; then
		eerror "You requested avahi support, but this package requires"
		eerror "the howl-compat support enabled in net-dns/avahi to work"
		eerror "with it."
		eerror
		eerror "Please recompile net-dns/avahi with +howl-compat."
		die "Missing howl-compat support in avahi."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PN}-0.2.3-pidfile.patch"
	epatch "${FILESDIR}/${PN}-0.2.3-persist-fix.patch"
	epatch "${FILESDIR}/${PN}-0.2.3-sparc.patch"
	epatch "${FILESDIR}/${PN}-0.2.3-libsorder.patch"

	eautoreconf
}

src_compile() {
	local myconf=""
	local howlincludes

	# howl support?
	if use howl; then
		use avahi && \
			howlincludes="/usr/include/avahi-compat-howl" || \
			howlincludes="/usr/include/howl"

		myconf="${myconf}
			--enable-howl
			--with-howl-libs=/usr/$(get_libdir)
			--with-howl-includes=${howlincludes}"
	fi

	# Bug 65723
	if use vorbis; then
		myconf="${myconf} --enable-oggvorbis"
	fi

	econf ${myconf} || die "configure failed"
	emake || die "make failed"

	cp ${FILESDIR}/${PN}.init.2 ${WORKDIR}/initd
	if ! use howl; then
		sed -i -e '/#USEHOWL/d' ${WORKDIR}/initd
	elif ! use avahi; then
		sed -i -e 's:#USEHOWL ::' ${WORKDIR}/initd
	else
		sed -i -e 's:#USEHOWL ::; s:mDNSResponder:avahi-daemon:' ${WORKDIR}/initd
	fi
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
		use avahi && \
			howlservice="avahi-daemon" || \
			howlservice="mDNSResponder"

		einfo
		einfo "Since you want to use howl instead of the internal mdnsd"
		einfo "you need to make sure that you have ${howlservice} configured"
		einfo "and running to use mt-daapd."
		einfo

		if use avahi; then
			einfo "Avahi support is currently experimental, it does not work"
			einfo "as intended when using more than one mt-daapd instance."
			einfo "If you want to run more than one mt-daapd, just use the"
			einfo "internal mdnsd by building with -howl flag."
		fi
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
