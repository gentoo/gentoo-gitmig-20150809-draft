# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/gtk2hs/gtk2hs-0.9.6-r1.ebuild,v 1.1 2004/11/04 14:57:15 kosmikus Exp $

inherit base ghc-package

DESCRIPTION="GTK+-2.x bindings for Haskell"
HOMEPAGE="http://gtk2hs.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtk2hs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

IUSE="doc gnome"

RDEPEND=">=virtual/ghc-5.04
		>=x11-libs/gtk+-2
		gnome? ( >=gnome-base/libglade-2
				 >=x11-libs/gtksourceview-0.6
				 >=gnome-base/gconf-2)"

DEPEND="${RDEPEND}"

src_compile() {
	econf \
		--libdir=$(ghc-libdir) \
		--with-hcflags="-H180m" \
		`use_enable gnome gnome` \
		`use_enable gnome libglade` \
		|| die "Configure failed"

	#fix for bug in 0.9.6 tarball, directory missing so don't compile that demo
	sed -i 's/MAKE_APPS += demo\/filechooser//' ${S}/Makefile
	#or work out how to build without demos

	# parallel build doesn't work, so specify -j1
	emake -j1 || die "Make failed"

	if use doc; then
		make html || die "Make docs failed"
	fi
}

src_install() {

	make DESTDIR=${D} install-without-pkg || die "Make install failed"
	if use doc; then
		make DESTDIR=${D} install-html || die "Make docs failed"
	fi

	# fix dynamic linking with pthread bug for glade & sourview
	if use gnome; then
		sed -i 's:"pthread",::' ${D}/$(ghc-libdir)/gtk2hs/sourceview/sourceview.conf
		sed -i 's:"pthread",::' ${D}/$(ghc-libdir)/gtk2hs/glade/glade.conf
	fi

	# arrange for the packages to be registered
	ghc-setup-pkg \
		"${D}/$(ghc-libdir)/gtk2hs/gtk2/gtk2.conf" \
		"${D}/$(ghc-libdir)/gtk2hs/mogul/mogul.conf" \
		$(useq gnome && echo \
			"${D}/$(ghc-libdir)/gtk2hs/glade/glade.conf" \
			"${D}/$(ghc-libdir)/gtk2hs/gconf/gconf.conf" \
			"${D}/$(ghc-libdir)/gtk2hs/sourceview/sourceview.conf")
	ghc-install-pkg

	# build ghci .o files from .a files
	ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/gtk2/libgtk2hs.a
	ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/mogul/libmogul.a
	if use gnome; then
		ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/sourceview/libsourceview.a
		ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/glade/libglade2hs.a
		ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/gconf/libgconf.a
	fi

	# fix gconf hi file location install bug
	if use gnome; then
		mkdir -p "${D}/$(ghc-libdir)/gtk2hs/gconf/hi/System/Gnome/GConf"
		mv ${D}/$(ghc-libdir)/gtk2hs/gconf/hi/GConf.hi \
			${D}/$(ghc-libdir)/gtk2hs/gconf/hi/System/Gnome/
		mv ${D}/$(ghc-libdir)/gtk2hs/gconf/hi/*.hi \
			${D}/$(ghc-libdir)/gtk2hs/gconf/hi/System/Gnome/GConf/
	fi
}

