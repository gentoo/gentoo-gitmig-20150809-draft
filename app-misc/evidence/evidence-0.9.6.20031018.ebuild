# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/evidence/evidence-0.9.6.20031018.ebuild,v 1.2 2003/10/18 09:44:12 vapier Exp $

inherit enlightenment eutils flag-o-matic

DESCRIPTION="GTK2 file-manager"
HOMEPAGE="http://evidence.sourceforge.net/"

LICENSE="GPL-2"
IUSE="${IUSE} perl X mad oggvorbis truetype gnome kde"

# doesnt build
#	gnome? ( >=gnome-base/gnome-vfs-2.0
#		>=media-libs/libart_lgpl-2.0
#		>=gnome-base/libgnomecanvas-2.0 )
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
	app-admin/fam-oss
	>=sys-fs/efsd-0.0.1.20031013
	>=x11-libs/evas-1.0.0.20031018_pre12
	>=dev-db/edb-1.0.4
	>=dev-libs/eet-0.9.0.20031013
	>=x11-libs/ecore-1.0.0.20031018_pre4
	>=media-libs/imlib2-1.1.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-info-direntry.patch
	epatch ${FILESDIR}/${PV}-makefile-gtk.patch
}

src_compile() {
	# if we turn this on evas gets turned off (bad !)
	#use gnome && MY_ECONF="${MY_ECONF} --enable-canvas-gnomecanvas"

	# cannot use use_enable constructs because configure script is wrong
	export MY_ECONF="
		--enable-backend-efsd
		--enable-extra-themes
		--enable-extra-iconsets
		"
	use perl || MY_ECONF="${MY_ECONF} --disable-pcre"
	use X || MY_ECONF="${MY_ECONF} --disable-x"
	use mad || MY_ECONF="${MY_ECONF} --disable-libmad"
	use oggvorbis || MY_ECONF="${MY_ECONF} --disable-plugin-vorbis"
	use truetype || MY_ECONF="${MY_ECONF} --disable-plugin-ttf"
#	use gnome && MY_ECONF="${MY_ECONF} --enable-backend-gnomevfs2"
	use kde && MY_ECONF="${MY_ECONF} --enable-backend-kio"

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
