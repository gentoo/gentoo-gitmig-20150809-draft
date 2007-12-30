# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop/monodevelop-0.18.ebuild,v 1.1 2007/12/30 09:36:33 compnerd Exp $

inherit autotools eutils fdo-mime mono multilib

DESCRIPTION="Integrated Development Environemnt for .NET"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aspnet firefox subversion xulrunner"

RDEPEND=">=dev-lang/mono-1.1.10
		 >=dev-util/monodoc-1.0
		 >=dev-dotnet/mono-addins-0.3
		 >=dev-dotnet/gtk-sharp-2.8
		 >=dev-dotnet/glade-sharp-2.8
		 >=dev-dotnet/gnome-sharp-2.8
		 >=dev-dotnet/gnomevfs-sharp-2.8
		 >=dev-dotnet/gconf-sharp-2.8
		 >=dev-dotnet/gtksourceview-sharp-0.10
		 aspnet? ( >=dev-dotnet/xsp-1.2.1 )
		 firefox? ( || ( www-client/mozilla-firefox www-client/mozilla-firefox-bin ) )
		 subversion? ( dev-util/subversion )
		 xulrunner? ( net-libs/xulrunner )"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		  x11-misc/shared-mime-info
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	if use aspnet && ! ( use firefox || use xulrunner ) ; then
		eerror
		eerror "You cannot install the ASP.NET Visual Designer unless you"
		eerror "add support for either Mozilla Firefox, Mozilla XULRunner"
		eerror "by enabling the appropriate use flag"
		eerror
		die
	fi
}

src_compile() {
	econf --disable-update-mimedb		\
		  --disable-update-desktopdb	\
		  $(use_enable aspnet)			\
		  $(use_enable subversion)		\
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
