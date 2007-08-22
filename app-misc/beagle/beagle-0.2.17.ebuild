# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beagle/beagle-0.2.17.ebuild,v 1.2 2007/08/22 18:51:41 jurek Exp $

inherit gnome.org eutils autotools mono

DESCRIPTION="search tool that ransacks your personal information space to find whatever you're looking for"
HOMEPAGE="http://www.beagle-project.org/"

LICENSE="MIT Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="chm doc evo galago gtk ole pdf python thunderbird"

RDEPEND="
	>=dev-lang/mono-1.1.13.5
	app-shells/bash
	app-arch/zip
	sys-devel/gettext
	>=x11-libs/gtk+-2.6.0
	>=dev-libs/atk-1.2.4
	>=dev-libs/gmime-2.2.1
	>=dev-dotnet/gtk-sharp-2.8
	>=gnome-base/librsvg-2.0
	>=media-libs/libexif-0.6.0
	>=dev-libs/libxml2-2.6.19
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXt

	||		(	>=dev-db/sqlite-3.3.1
				=dev-db/sqlite-2* )

	gtk?	(	>=dev-dotnet/gconf-sharp-2.8
				>=dev-dotnet/glade-sharp-2.8
				>=dev-dotnet/gnome-sharp-2.8 )

	python? (	>=dev-lang/python-2.3
				>=dev-python/pygtk-2.6 )

	evo?	(	>=dev-dotnet/evolution-sharp-0.10.2
				>=dev-dotnet/gconf-sharp-2.3 )

	ole?	(	>=app-text/wv-1.2.0
				>=dev-dotnet/gsf-sharp-0.6
				>=app-office/gnumeric-1.4.3-r3 )
	pdf?	(	>=app-text/poppler-0.5.1 )
	chm?	(	app-doc/chmlib )
	galago? (	>=dev-dotnet/galago-sharp-0.5.0 )
	doc?	(	dev-util/gtk-doc )
	thunderbird?	(	>=mail-client/mozilla-thunderbird-1.5 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xproto
	x11-proto/scrnsaverproto"

pkg_setup() {
	if built_with_use dev-libs/gmime mono
	then
		einfo "Mono support enabled in dev-libs/gmime, I will continue..."
	else
		eerror "Please rebuild dev-libs/gmime, with mono support enabled!"
		eerror "Try USE=\"mono\" emerge dev-libs/gmime,"
		eerror "or add \"mono\" to your USE string in /etc/make.conf and"
		eerror "emerge dev-libs/gmime."
		die "Mono USE flag must be enabled in dev-libs/gmime"
	fi

	enewgroup beagleindex
	enewuser beagleindex -1 -1 /var/lib/cache/beagle beagleindex
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Multilib fix
	sed -i -e 's:prefix mono`/lib:libdir mono`:' \
		${S}/configure.in || die "sed failed"

	epatch ${FILESDIR}/${PN}-0.2.7-crawltweek.patch
	epatch ${FILESDIR}/${PN}-log-level-warn.patch

	eautoreconf
}

src_compile() {
	econf \
		$(use_enable doc gtk-doc) \
		$(use_enable thunderbird) \
		$(use_enable evo evolution) \
		$(use_enable gtk gui) \
		$(use_enable python ) \
		$(use_enable ole gsf-sharp ) \
		--enable-libbeagle \
		|| die "configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed!"

	dodir /usr/share/beagle
	insinto /usr/share/beagle
	doins mozilla-extension/beagle.xpi

	dodoc AUTHORS INSTALL NEWS README

	sed -i 's/CRAWL_ENABLED="yes"/CRAWL_ENABLED="no"/' ${D}/etc/beagle/crawl-*

	insinto /etc/beagle
	doins ${FILESDIR}/crawl-portage

	keepdir /usr/$(get_libdir)/beagle/Backends
	diropts -o beagleindex -g beagleindex
	keepdir /var/lib/cache/beagle/indexes
}

pkg_postinst() {
	elog "If available, Beagle greatly benefits from using certain operating"
	elog "system features such as Extended Attributes and inotify."
	echo
	elog "If you want static queryables such as the portage tree and system"
	elog "documentation you will need to edit the /etc/beagle/crawl-* files"
	elog "and change CRAWL_ENABLE from 'no' to 'yes'."
	echo
	elog "For more info on how to create the optimal beagle environment, and"
	elog "basic usage info, see the Gentoo page of the Beagle website:"
	elog " http://www.beagle-project.org/Gentoo_Installation"
}
