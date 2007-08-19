# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop/monodevelop-0.15.ebuild,v 1.1 2007/08/19 01:24:26 jurek Exp $

inherit autotools eutils fdo-mime mono multilib

DESCRIPTION="Integrated Development Environemnt for .NET"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aspnet aspnetedit boo firefox java seamonkey subversion"

RDEPEND=">=dev-lang/mono-1.1.10
		 >=dev-util/monodoc-1.0
		 >=dev-dotnet/gtk-sharp-2.8.0
		 >=dev-dotnet/gconf-sharp-2.4
		 >=dev-dotnet/glade-sharp-2.4
		 >=dev-dotnet/gnome-sharp-2.4
		 >=dev-dotnet/gecko-sharp-0.10
		 >=dev-dotnet/gtkhtml-sharp-2.4
		 >=dev-dotnet/gnomevfs-sharp-2.4
		 >=dev-dotnet/gtksourceview-sharp-0.10
		 aspnet? ( >=dev-dotnet/xsp-1.2.1 )
		 aspnetedit? ( dev-dotnet/jscall-sharp )
		 boo? ( >=dev-lang/boo-0.7.6 )
	 	 firefox? ( || ( www-client/mozilla-firefox www-client/mozilla-firefox-bin ) )
		 java? ( || ( >=dev-dotnet/ikvm-0.14.0.1-r1 >=dev-dotnet/ikvm-bin-0.14.0.1 ) )
		 seamonkey? ( || ( www-client/seamonkey www-client/seamonkey-bin ) )
		 subversion? ( dev-util/subversion )"

		 # Removed due to nemerle compatibility issues (bugs #158241, #168208)
		 # nemerle? ( >=dev-lang/nemerle-0.9.3.99 <=dev-lang/nemerle-0.9.3.99.6855 )

DEPEND="${RDEPEND}
		  x11-misc/shared-mime-info
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19"

pkg_setup() {
	if use aspnetedit && ! use aspnet; then
		eerror
		eerror "You cannot install the ASP.NET Visual Designer unless you"
		eerror "add ASP.NET support by enabling the aspnet use flag"
		eerror
		die
	fi

	if use aspnetedit && ! ( use firefox || use seamonkey ); then
		eerror
		eerror "You cannot install the ASP.NET Visual Designer unless you"
		eerror "add support for either Mozilla Firefox or Mozilla Seamonkey"
		eerror "web browser by enabling the firefox or seamonkey use flag"
		eerror "respectively"
		eerror
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${P}-aspnet-template-fix.patch

	# Bundled jscall version is messed up
	if use aspnetedit; then
		ebegin "Fixing bundled jscall"
		jscalldir=Extras/AspNetEdit/libs/
		rm ${jscalldir}/jscall.dll
		ln -s /usr/$(get_libdir)/jscall-sharp/JSCall.js ${jscalldir} \
			|| die "ln failed"
		ln -s /usr/$(get_libdir)/jscall-sharp/jscall.dll ${jscalldir} \
			|| die "ln failed"

		# We handle installation of aspdesigner.jar by ourselves
		sed -i -e 's#old-install-files install-chrome-text$##g' \
			-e 's#install-files install-manifest$##g' \
			Extras/AspNetEdit/chrome/Makefile.am \
			|| die "sed failed"
		sed -i -e 's#@prefix@/lib/monodevelop/AddIns/AspNetEdit/##g' \
			Extras/AspNetEdit/chrome/aspdesigner.manifest.in \
			|| die "sed failed"
		eend
	fi

	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf --disable-update-mimedb			\
		  --disable-update-desktopdb		\
		  --enable-monoextensions			\
		  --enable-versioncontrol			\
		  --enable-monoquery				\
		  --disable-nemerle					\
		  $(use_enable aspnet)				\
		  $(use_enable aspnetedit)			\
		  $(use_enable boo)					\
		  $(use_enable java)				\
		  $(use_enable subversion)			\
	|| die "configure failed"

	emake -j1 || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	# We handle installation of aspdesigner.jar by ourselves
	if use aspnetedit; then
		if use firefox; then
			insinto /usr/$(get_libdir)/mozilla-firefox/chrome
			doins Extras/AspNetEdit/chrome/aspdesigner.{manifest,jar}
		fi
		if use seamonkey; then
			insinto /usr/$(get_libdir)/seamonkey/chrome
			doins Extras/AspNetEdit/chrome/aspdesigner.{manifest,jar}
		fi
	fi

	dodoc ChangeLog README || die "dodoc failed"
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update

	elog
	elog "Nemerle support has been explicitly dropped in this release of"
	elog "monodevelop. This happened mostly because of uncertain status of"
	elog "bundled nemerle addin. To learn more visit:"
	elog "http://bugs.gentoo.org/show_bug.cgi?id=168208#c31"
	elog

	if use aspnetedit; then
		ewarn
		ewarn "The ASP.NET visual designer bundled with MonoDevelop is still"
		ewarn "under heavy development, so it may contain numerous bugs. In case"
		ewarn "you encounter problems using it, before filing a bug please visit"
		ewarn "http://bugzilla.ximian.com and check if someone has already"
		ewarn "reported a similar issue"
		ewarn
	fi
}
