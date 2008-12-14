# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop/monodevelop-1.0.ebuild,v 1.3 2008/12/14 14:49:06 loki_val Exp $

inherit autotools eutils fdo-mime mono multilib

DESCRIPTION="Integrated Development Environemnt for .NET"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aspnet cxx subversion"

RDEPEND=">=dev-lang/mono-1.9
		 >=virtual/monodoc-1.9
		 >=dev-dotnet/mono-addins-0.3.1
		 >=dev-dotnet/gtk-sharp-2.8
		 >=dev-dotnet/glade-sharp-2.8
		 >=dev-dotnet/gnome-sharp-2.8
		 >=dev-dotnet/gnomevfs-sharp-2.8
		 >=dev-dotnet/gconf-sharp-2.8
		 >=dev-dotnet/gtksourceview-sharp-0.10
		 || (
				www-client/mozilla-firefox
		 		www-client/mozilla-firefox-bin
				www-client/seamonkey
				net-libs/xulrunner
			)
		 aspnet? ( >=dev-dotnet/xsp-1.9 )
		 subversion? ( dev-util/subversion )
		 cxx? ( dev-util/ctags )"

DEPEND="${RDEPEND}
		  sys-devel/gettext
		  x11-misc/shared-mime-info
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19"

MAKEOPTS="-j1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-configure.patch"
	epatch "${FILESDIR}/${P}-libstetic.patch"
	epatch "${FILESDIR}/${P}-parallel-build.patch"

	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf --disable-update-mimedb		\
		  --disable-update-desktopdb	\
		  --enable-monoextensions		\
		  --enable-versioncontrol		\
		  $(use_enable aspnet)			\
		  $(use_enable subversion)		\
		  $(use_enable cxx c)			\
	|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog README || die "dodoc failed"
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
