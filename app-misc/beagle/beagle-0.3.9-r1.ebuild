# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beagle/beagle-0.3.9-r1.ebuild,v 1.3 2009/05/14 20:40:05 maekke Exp $

EAPI=2

inherit base gnome.org eutils mono mozextension

DESCRIPTION="Search tool that ransacks your personal information space to find whatever you're looking for"
HOMEPAGE="http://www.beagle-project.org/"
LICENSE="MIT Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="avahi chm debug doc epiphany eds firefox +galago gtk +pdf +inotify +ole thunderbird +google  +xscreensaver"

#See bug 248331 for blocker reason.
RDEPEND="!!sci-libs/beagle
	>=dev-lang/mono-1.9
	>=app-shells/bash-3.2
	app-arch/zip
	>=dev-db/sqlite-3.3.1
	>=dev-dotnet/dbus-sharp-0.6.0
	>=dev-dotnet/dbus-glib-sharp-0.4.1
	>=dev-dotnet/taglib-sharp-2.0
	gtk? (
		x11-libs/libX11
		>=gnome-base/librsvg-2.22.0
		sys-devel/gettext
		>=dev-dotnet/gtk-sharp-2.12.6
		>=dev-dotnet/gconf-sharp-2.24.0
		>=dev-dotnet/glade-sharp-2.12.6
		>=dev-dotnet/gnome-sharp-2.24.0
		>=dev-dotnet/gnomevfs-sharp-2.24.0
		dev-libs/gmime:0[mono]
		x11-misc/xdg-utils
		>=x11-libs/gtk+-2.14.0
		>=dev-libs/atk-1.22.0
	)
	eds? (
		>=dev-dotnet/evolution-sharp-0.18.1
		>=dev-dotnet/gconf-sharp-2.24.0
		>=dev-dotnet/glib-sharp-2.12.6
		dev-libs/gmime:0[mono]
	)
	ole? (
		>=app-text/wv-1.2.3
		>=dev-dotnet/gsf-sharp-0.8.1
		>=app-office/gnumeric-1.4.3-r3
	)

	x11-misc/shared-mime-info
	>=dev-dotnet/glib-sharp-2.12.6
	dev-libs/gmime:0[mono]
	chm? ( dev-libs/chmlib )
	pdf? ( >=virtual/poppler-utils-0.8 )
	galago? ( >=dev-dotnet/galago-sharp-0.5.0 )
	thunderbird? (
			|| (
				>=mail-client/mozilla-thunderbird-1.5
				>=mail-client/mozilla-thunderbird-bin-1.5
			)
	)
	firefox? (
			|| (
				>=www-client/mozilla-firefox-1.5
				>=www-client/mozilla-firefox-bin-1.5
			)
	)
	epiphany? (
		>=www-client/epiphany-extensions-2.16[python]
		>=dev-libs/libbeagle-0.3.9[python]
	)
	xscreensaver? ( x11-libs/libXScrnSaver )
	>=dev-libs/libbeagle-0.3.9
	avahi?	( >=net-dns/avahi-0.6.10[mono] )"

DEPEND="${RDEPEND}
	doc? ( >=virtual/monodoc-1.2.4 )
	dev-util/pkgconfig
	xscreensaver? ( x11-proto/scrnsaverproto )
	>=dev-util/intltool-0.35"

pkg_setup() {
	enewgroup beagleindex
	enewuser beagleindex -1 -1 /var/lib/cache/beagle beagleindex
	if use thunderbird
	then
		if ! use inotify
		then
			eerror "You have enabled the thunderbird use flag. This use-flag depends on the inotify use-flag."
			eerror "Please enable the inotify use-flag also."
			eerror "See http://bugs.gentoo.org/263781 for more information."
			die "Please enable inotify use-flag."
		fi
	fi
}

src_prepare() {
	#Fix bug 248703
	sed -i  -e 's:VALID_EPIPHANY_VERSIONS=":VALID_EPIPHANY_VERSIONS="2.26 2.25 2.24 :' \
		configure || die "epiphany sed failed"

	#Fix bugs.gnome.org/556243
	sed -i	-e "s:libgnome-desktop-2.so.2:libgnome-desktop-2.so:" \
		search/Beagle.Search.exe.config || die "gnome-desktop sed failed"
}

src_configure() {
	econf 	--disable-static \
		--disable-dependency-tracking \
		$(use_enable debug xml-dump) \
		$(use_enable doc docs) \
		$(use_enable epiphany epiphany-extension) \
		$(use_enable thunderbird) \
		$(use_enable eds evolution) \
		$(use_enable gtk gui) \
		$(use_enable ole gsf-sharp wv1) \
		$(use_enable xscreensaver xss) \
		$(use_enable inotify) \
		$(use_enable avahi) \
		$(use_enable google googlebackends)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	dodoc AUTHORS NEWS README || die "dodoc failed"

	declare MOZILLA_FIVE_HOME
	if use firefox; then
		xpi_unpack "${S}"/firefox-extension/beagle.xpi \
		|| die "Unable to find Beagle Firefox Extension"
		mv "${WORKDIR}"/beagle "${WORKDIR}"/firefox-beagle

		if has_version '>=www-client/mozilla-firefox-1.5'; then
			MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-firefox"
			xpi_install "${WORKDIR}"/firefox-beagle \
			|| die "xpi install for mozilla-firefox failed!"
		fi
		if has_version '>=www-client/mozilla-firefox-bin-1.5'; then
			MOZILLA_FIVE_HOME="/opt/firefox"
			xpi_install "${WORKDIR}"/firefox-beagle \
			|| die "xpi install for mozilla-firefox-bin failed!"
		fi
	fi

	if use thunderbird; then
		xpi_unpack "${S}"/thunderbird-extension/beagle.xpi \
		|| die "Unable to find Beagle Thunderbird Extension"
		mv "${WORKDIR}"/beagle "${WORKDIR}"/thunderbird-beagle

		if has_version '>=mail-client/mozilla-thunderbird-1.5'; then
			MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-thunderbird"
			xpi_install "${WORKDIR}"/thunderbird-beagle \
			|| die "xpi install for mozilla-thunderbird failed!"
		fi
		if has_version '>=mail-client/mozilla-thunderbird-bin-1.5'; then
			MOZILLA_FIVE_HOME="/opt/thunderbird"
			xpi_install "${WORKDIR}"/thunderbird-beagle \
			|| die "xpi install for mozilla-thunderbird-bin failed!"
		fi
	fi

	sed -i -e 's/CRAWL_ENABLED="yes"/CRAWL_ENABLED="no"/' \
		"${D}"/etc/beagle/crawl-rules/crawl-*

	insinto /etc/beagle/crawl-rules
	doins "${FILESDIR}/crawl-portage"

	keepdir "/usr/$(get_libdir)/beagle/Backends"
	diropts -o beagleindex -g beagleindex
	keepdir "/var/lib/cache/beagle/indexes"
}

pkg_postinst() {
	elog "If available, Beagle greatly benefits from using certain operating"
	elog "system features such as Extended Attributes and inotify."
	elog
	elog "If you want static queryables such as the portage tree and system"
	elog "documentation you will need to edit the /etc/beagle/crawl-* files"
	elog "and change CRAWL_ENABLE from 'no' to 'yes'."
	elog
	elog "For more info on how to create the optimal beagle environment, and"
	elog "basic usage info, see the Gentoo page of the Beagle website:"
	elog "http://www.beagle-project.org/Gentoo_Installation"
}
