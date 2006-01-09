# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beagle/beagle-0.1.2.ebuild,v 1.6 2006/01/09 22:30:05 mr_bones_ Exp $

inherit gnome.org eutils mono

DESCRIPTION="search tool that ransacks your personal information space to find whatever you're looking for"
HOMEPAGE="http://www.beagle-project.org/"

LICENSE="MIT Apache-1.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="spreadsheet pdf webservices chm debug"

RDEPEND=">=dev-lang/mono-1.1.10
	app-shells/bash
	app-arch/zip
	sys-devel/gettext
	=dev-db/sqlite-2*
	=gnome-base/gnome-vfs-2*
	=gnome-base/libgnome-2*
	>=www-client/mozilla-1.6
	>=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.6
	>=dev-dotnet/gtk-sharp-2.3
	>=dev-dotnet/glade-sharp-2.3
	>=dev-dotnet/gecko-sharp-0.11
	>=dev-dotnet/gnome-sharp-2.3
	>=dev-dotnet/gnomevfs-sharp-2.3
	>=dev-dotnet/gconf-sharp-2.3
	>=dev-libs/gmime-2.1.16
	>=dev-libs/atk-1.2.4
	>=media-libs/libexif-0.6.0
	>=dev-libs/libxml2-2.6.19
	chm? ( app-doc/chmlib )
	pdf? ( app-text/xpdf )
	spreadsheet? ( >=app-office/gnumeric-1.4.3-r3 )
	|| ( ( x11-libs/libX11
		x11-libs/libXScrnSaver
		x11-libs/libXt )
	virtual/x11 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	|| ( (	x11-proto/xproto
		x11-proto/scrnsaverproto )
	virtual/x11 )"

EXTRA_EMAKE="-j1"

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
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# To prevent excessive revdep-rebuild, gentoo's libexif is sticking to
	# soversion 10 for now.
	sed -i -e 's/EXIF_SOVERSION=12/EXIF_SOVERSION=10/' configure.in

	# Multilib fix
	sed -i -e 's:prefix mono`/lib:libdir mono`:' \
		${S}/{configure.in,configure} || die "sed failed"

	# Don't log so much
	! use debug && sed -i -e \
		's/defaultLevel = LogLevel.Debug/defaultLevel = LogLevel.Info/' \
		Util/Logger.cs
}

src_compile() {
	econf $(use_enable webservices) \
		--enable-libbeagle \
		--disable-evolution-sharp \
		|| die "configure failed"
	emake -j1 || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed!"

	dodir /usr/share/beagle
	insinto /usr/share/beagle
	doins mozilla-extension/beagle.xpi

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}

pkg_postinst() {
	einfo "If available, Beagle greatly benefits from using certain operating"
	einfo "system features such as Extended Attributes and inotify."
	echo
	einfo "For more info on how to create the optimal beagle environment, and"
	einfo "basic usage info, see the Gentoo page of the Beagle website:"
	einfo " http://www.beagle-project.org/Gentoo_Installation"
}
