# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mt-daapd/mt-daapd-0.3.0_pre20060220.ebuild,v 1.1 2006/02/21 14:01:02 flameeyes Exp $

inherit eutils flag-o-matic

CVS="${PV#*pre}"

if [[ -n ${CVS} ]] ; then
	MY_P="${PN}-cvs-${CVS}"
	SRC_URI="http://nightlies.mt-daapd.org/${MY_P}.tar.gz"
else
	MY_P="${P/_/-}"
	SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
fi

S="${WORKDIR}/${MY_P}"

DESCRIPTION="A multi-threaded implementation of Apple's DAAP server"
HOMEPAGE="http://www.mt-daapd.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~sh ~sparc ~x86"
IUSE="howl vorbis avahi sqlite3 flac"

DEPEND="sys-libs/zlib
	media-libs/libid3tag
	!sqlite3? ( =dev-db/sqlite-2* )
	sqlite3? ( =dev-db/sqlite-3* )
	howl? ( !avahi? ( >=net-misc/howl-0.9.2 )
		avahi? ( net-dns/avahi ) )
	vorbis? ( media-libs/libvorbis )
	flac? ( media-libs/flac )"

pkg_setup() {
	if use howl && use avahi && ! built_with_use net-dns/avahi howl-compat; then
		eerror "You requested avahi support, but this package requires"
		eerror "the howl-compat support enabled in net-dns/avahi to work"
		eerror "with it."
		eerror
		eerror "Please recompile net-dns/avahi with +howl-compat."
		die "Missing howl-compat support in avahi."
	fi

	if use sqlite && use sqlite3; then
		eerror "You can't enable both sqlite 2.x and sqlite 3.x suppor at the"
		eerror "same time. Please drop one of the useflag."
		die "Invalid use of sqlite flags"
	fi
}

src_compile() {
	local myconf=""
	local howlincludes

	append-flags -fno-strict-aliasing

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

	econf \
		$(use_enable vorbis oggvorbis) \
		$(use_enable flac) \
		$(use_enable !sqlite3 sqlite) \
		$(use_enable sqlite3) \
		${myconf} || die "configure failed"
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
