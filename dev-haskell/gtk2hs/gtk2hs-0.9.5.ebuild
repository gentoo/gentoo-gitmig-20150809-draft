# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/gtk2hs/gtk2hs-0.9.5.ebuild,v 1.3 2005/01/01 18:04:13 eradicator Exp $

DESCRIPTION="GTK+-2.x bindings for Haskell"
HOMEPAGE="http://gtk2hs.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtk2hs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

IUSE="gnome"

RDEPEND=">=virtual/ghc-6.2
	>=x11-libs/gtk+-2
	gnome? ( >=gnome-base/libglade-2
		>=x11-libs/gtksourceview-0.6 )"

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
		`use_enable gnome sourceview` \
		`use_enable gnome libglade` \
		--disable-glext \
		${myopts} \
		|| die "Configure failed"

	# parallel build doesn't work, so specify -j1
	emake -j1 || die "Make failed"
}

src_install() {

	make install-without-pkg || die "Make install failed"

	# correct the package config files
	sed -i "s:${D}::g" ${D}/${ghclibdir}/*.conf

	# build ghci .o files from .a files
	ld -r -x -o ${D}/${ghclibdir}/gtk2hs.o \
		--whole-archive ${D}/${ghclibdir}/libgtk2hs.a
	ld -r -x -o  ${D}/${ghclibdir}/mogul.o \
		--whole-archive ${D}/${ghclibdir}/libmogul.a
	use gnome && ld -r -x -o  ${D}/${ghclibdir}/sourceview.o \
		--whole-archive ${D}/${ghclibdir}/libsourceview.a
	use gnome && ld -r -x -o  ${D}/${ghclibdir}/glade2hs.o \
		--whole-archive ${D}/${ghclibdir}/libglade2hs.a
}

pkg_postinst() {
	register_ghc_packages
}

register_ghc_packages() {
	einfo "Registering gtk2hs packages"
	ghc-pkg -u -i ${ghclibdir}/gtk2.conf
	ghc-pkg -u -i ${ghclibdir}/mogul.conf
# sourceview package not usable from ghci due to linking problems
#	use gnome && ghc-pkg -u -i ${ghclibdir}/sourceview.conf
	use gnome && ghc-pkg -u -i ${ghclibdir}/glade.conf
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
}

