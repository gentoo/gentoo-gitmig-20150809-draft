# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/evidence/evidence-0.9.6.20030629_pre1.ebuild,v 1.2 2003/06/30 23:56:20 vapier Exp $

inherit enlightenment eutils

DESCRIPTION="GTK2 file-manager"
HOMEPAGE="http://evidence.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"
IUSE="${IUSE} perl X libao libmad oggvorbis id3 truetype"

#	gnome? ( >=gnome-base/gnome-vfs-2.0 >=gnome-base/libgnomecanvas-2.0 )
DEPEND=">=dev-util/pkgconfig-0.5
	=x11-libs/gtk+-2*
	oggvorbis? ( media-libs/libvorbis
		media-libs/libogg )
	perl? ( dev-libs/libpcre )
	X? ( virtual/x11 )
	gnome? ( >=gnome-base/gnome-vfs-2.0
		>=media-libs/libart_lgpl-2.0
		>=gnome-base/libgnomecanvas-2.0 )
	libao? ( media-libs/libao )
	libmad? ( media-sound/mad )
	truetype? ( =media-libs/freetype-2* )
	virtual/glibc
	sys-devel/gcc
	app-admin/fam-oss
	>=sys-apps/efsd-0.0.1.2003*
	>=x11-libs/evas-1.0.0.2003*
	>=dev-db/edb-1.0.3.2003*
	>=dev-libs/eet-0.0.1.2003*
	>=media-libs/ebg-1.0.0.2003*
	>=media-libs/ebits-1.0.1.2003*
	>=media-libs/imlib2-1.0.6.2003*"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-info-direntry.patch || die "patch failed"

	for x in evidence.themes/engines/sb_edb.c setup/* ; do
		if [ -f "${x}" ] ; then
			cp ${x} ${x}.orig
			sed -e 's|usr/local|usr|g' ${x}.orig > ${x}
			rm -f ${x}.orig
		fi
	done
}

src_compile() {
	env NOCONFIGURE=no WANT_AUTOCONF_2_5=1 \
	./autogen.sh || die "could not autogen"

	# causes compilation to fail: [has undefine constants]
	# --enable-backend-script
	#use gnome && myconf="${myconf} --enable-backend-gnomevfs --enable-canvas-gnomecanvas"

	# cannot use use_enable constructs because configure script is wrong
	local myconf=""
	use perl || myconf="${myconf} --disable-pcre"
	use X || myconf="${myconf} --disable-x"
	use libao || myconf="${myconf} --disable-ao"
	use libmad || myconf="${myconf} --disable-libmad"
	use oggvorbis || myconf="${myconf} --disable-plugin-vorbis"
	use id3 || myconf="${myconf} --disable-plugin-id3"
	use truetype || myconf="${myconf} --disable-plugin-ttf"

	econf \
		${myconf} \
		--enable-backend-efsd \
		--enable-extra-themes \
		--enable-extra-iconsets \
		|| die

	emake || die
}

src_install() {
	einstall || die
	
	find ${D} -name CVS -type d -exec rm -rf '{}' \;

	# Fixup broken symlinks
	dosym gfilerunner /usr/share/evidence/icons/default
	dosym efm /usr/share/evidence/themes/default

	dodoc AUTHORS ChangeLog NEWS README docs/*
}
