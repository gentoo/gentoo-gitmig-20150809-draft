# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/evidence/evidence-0.9.7.20040117.ebuild,v 1.1 2004/01/20 05:12:59 vapier Exp $

inherit enlightenment eutils flag-o-matic

DESCRIPTION="GTK2 file-manager"
HOMEPAGE="http://evidence.sourceforge.net/"

LICENSE="GPL-2"
IUSE="${IUSE} perl X mad oggvorbis truetype gnome kde"

DEPEND=">=dev-util/pkgconfig-0.5
	=x11-libs/gtk+-2*
	oggvorbis? ( media-libs/libvorbis
		media-libs/libogg )
	perl? ( dev-libs/libpcre )
	X? ( virtual/x11 )
	mad? ( media-sound/mad )
	truetype? ( =media-libs/freetype-2* )
	kde? ( kde-base/kdelibs )
	media-libs/libao
	virtual/glibc
	sys-devel/gcc
	app-admin/fam
	>=sys-fs/efsd-0.0.1.20031013
	>=x11-libs/evas-1.0.0.20031018_pre12
	>=dev-db/edb-1.0.4
	>=dev-libs/eet-0.9.0.20031013
	>=x11-libs/ecore-1.0.0.20031018_pre4
	>=media-libs/imlib2-1.1.0
	gnome? ( >=gnome-base/gnome-vfs-2.0
		>=media-libs/libart_lgpl-2.0
		>=gnome-base/libgnomecanvas-2.0 )"

src_compile() {
	# if we turn this on evas gets turned off (bad !)
	#use gnome && MY_ECONF="${MY_ECONF} --enable-canvas-gnomecanvas"

#		`use_enable gnome backend-gnomevfs2`
#		`use_enable kde backend-kio`
	export MY_ECONF="
		--enable-ecore-ipc
		--enable-canvas-evas2
		--disable-backend-efsd
		--enable-extra-themes
		--enable-extra-iconsets
		`use_enable perl pcre`
		`use_enable x X`
		`use_enable mad libmad`
		`use_enable oggvorbis plugin-vorbis`
		`use_enable truetype plugin-ttf`
		`use_enable debug`
		"
	enlightenment_src_compile
}

src_install() {
	enlightenment_src_install

	# Fixup broken symlinks
	dosym efm /usr/share/evidence/icons/default
	dosym efm /usr/share/evidence/themes/default
	chown -R root:root ${D}/usr/share/evidence

	dodoc docs/*
}
