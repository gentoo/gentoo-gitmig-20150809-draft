# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/gtk2hs/gtk2hs-0.9.6.ebuild,v 1.1 2004/10/26 14:36:42 kosmikus Exp $

DESCRIPTION="GTK+-2.x bindings for Haskell"
HOMEPAGE="http://gtk2hs.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtk2hs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

IUSE="gnome"

RDEPEND=">=virtual/ghc-5.04
		>=x11-libs/gtk+-2
		gnome? ( >=gnome-base/libglade-2
		         >=x11-libs/gtksourceview-0.6
				 >=gnome-base/gconf-2)"

DEPEND="${RDEPEND}"

# the variable ghc_version is used to store the ghc version
# we are building against

src_compile() {
	# determine ghc library directory
	# (so that it's possible to install the library for
	# multiple versions of ghc)
	local myopts
	ghc_version=`best_version virtual/ghc | sed "s:.*/::"`
	test -n ${ghc_version} && ghclibdir="/usr/lib/${ghc_version}"
	test -n ${ghclibdir} || ghclibdir="/usr/lib"
	test -n ${ghclibdir} && myopts="${myopts} --libdir=${D}${ghclibdir}"

	# configure, override hc flags to not specify heap size
	econf --with-hcflags="-O" \
	    `use_enable gnome gnome` \
		`use_enable gnome libglade` \
		${myopts} \
		|| die "Configure failed"

	#fix for bug in 0.9.6 tarball, directory missing so don't compile that demo
	sed -i 's/MAKE_APPS += demo\/filechooser//' ${S}/Makefile
	#or work out how to build without demos

	# parallell build doesn't work, so specify -j1
	emake -j1 || die "Make failed"
}

src_install() {

	make install-without-pkg || die "Make install failed"

	#the following actions are all for bug fixes:

	# correct the package config files
	sed -i "s:${D}::g" ${D}/${ghclibdir}/gtk2hs/*/*.conf

	# build ghci .o files from .a files
	ld -r -x -o ${D}/${ghclibdir}/gtk2hs/gtk2/gtk2hs.o \
		--whole-archive ${D}/${ghclibdir}/gtk2hs/gtk2/libgtk2hs.a
	ld -r -x -o  ${D}/${ghclibdir}/gtk2hs/mogul/mogul.o \
		--whole-archive ${D}/${ghclibdir}/gtk2hs/mogul/libmogul.a
	[ `use gnome` ] && ld -r -x -o ${D}/${ghclibdir}/gtk2hs/sourceview/sourceview.o \
		--whole-archive ${D}/${ghclibdir}/gtk2hs/sourceview/libsourceview.a
	[ `use gnome` ] && ld -r -x -o ${D}/${ghclibdir}/gtk2hs/glade/glade2hs.o \
		--whole-archive ${D}/${ghclibdir}/gtk2hs/glade/libglade2hs.a
	[ `use gnome` ] && ld -r -x -o ${D}/${ghclibdir}/gtk2hs/gconf/gconf.o \
		--whole-archive ${D}/${ghclibdir}/gtk2hs/gconf/libgconf.a

	# fix dynamic linking with pthread bug for glade & sourview
	sed -i 's:"pthread",::' ${D}/${ghclibdir}/gtk2hs/sourceview/sourceview.conf
	sed -i 's:"pthread",::' ${D}/${ghclibdir}/gtk2hs/glade/glade.conf

	# fix gconf hi file location install bug
	mkdirhier ${D}/${ghclibdir}/gtk2hs/gconf/hi/System/Gnome/GConf
	mv ${D}/${ghclibdir}/gtk2hs/gconf/hi/GConf.hi \
	   ${D}/${ghclibdir}/gtk2hs/gconf/hi/System/Gnome/
	mv ${D}/${ghclibdir}/gtk2hs/gconf/hi/GConfClient.hi \
	   ${D}/${ghclibdir}/gtk2hs/gconf/hi/System/Gnome/GConf/
	mv ${D}/${ghclibdir}/gtk2hs/gconf/hi/GConfType.hi \
	   ${D}/${ghclibdir}/gtk2hs/gconf/hi/System/Gnome/GConf/
	mv ${D}/${ghclibdir}/gtk2hs/gconf/hi/GConfValue.hi \
	   ${D}/${ghclibdir}/gtk2hs/gconf/hi/System/Gnome/GConf/
}

pkg_postinst() {
	register_ghc_packages
}

register_ghc_packages() {
	einfo "Registering gtk2hs packages"
	ghc-pkg -u -i ${ghclibdir}/gtk2hs/gtk2/gtk2.conf
	ghc-pkg -u -i ${ghclibdir}/gtk2hs/mogul/mogul.conf
	[ `use gnome` ] && ghc-pkg -u -i ${ghclibdir}/gtk2hs/sourceview/sourceview.conf
	[ `use gnome` ] && ghc-pkg -u -i ${ghclibdir}/gtk2hs/glade/glade.conf
	[ `use gnome` ] && ghc-pkg -u -i ${ghclibdir}/gtk2hs/gconf/gconf.conf
}

pkg_prerm() {
	# check if another version is still there
	has_version "<${CATEGORY}/${PF}" \
		|| has_version ">${CATEGORY}/${PF}" \
		|| unregister_ghc_packages
}

unregister_ghc_packages() {
	einfo "Unregistering gtk2hs packages"
	ghc-pkg -r gtk2
	ghc-pkg -r mogul
	ghc-pkg -r glade
	ghc-pkg -r sourceview
	ghc-pkg -r gconf
}

