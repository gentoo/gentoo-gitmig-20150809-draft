# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/evidence/evidence-0.9.4.20030220-r2.ebuild,v 1.3 2003/06/30 23:56:20 vapier Exp $

inherit eutils

DESCRIPTION="GTK2 file-manager"
HOMEPAGE="http://evidence.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"
IUSE="oggvorbis perl X"

#	gnome? ( >=gnome-base/gnome-vfs-2.0 >=gnome-base/libgnomecanvas-2.0 )
DEPEND=">=dev-util/pkgconfig-0.5
	=x11-libs/gtk+-2*
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	perl? ( dev-libs/libpcre )
	X? ( virtual/x11 )
	gnome? ( >=gnome-base/gnome-vfs-2.0
		>=media-libs/libart_lgpl-2.0
		>=gnome-base/libgnomecanvas-2.0 )
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

	for x in evidence.themes/engines/sb_edb.c setup/*
	do
		if [ -f "${x}" ]
		then
			cp ${x} ${x}.orig
			sed -e 's|usr/local|usr|g' ${x}.orig > ${x}
			rm -f ${x}.orig
		fi
	done
}

src_compile() {
	env NOCONFIGURE=no WANT_AUTOCONF_2_5=1 \
	./autogen.sh || die "could not autogen"

	#causes compilation to fail: --enable-backend-script
	# has undefine constants
	local gnomeconf=
#	use gnome && gnomeconf="${myconf} --enable-backend-gnomevfs \
#	                                  --enable-canvas-gnomecanvas"
	econf \
		`use_enable oggvorbis plugin-vorbis` \
		`use_enable perl pcre` \
		`use_enable X x` \
		${gnomeconf} \
		--with-gnu-ld \
		--enable-backend-efsd \
		--enable-extra-themes \
		|| die

	emake || die
}

src_install() {
	einstall || die
	
	find ${D} -name CVS -type d -exec rm -rf '{}' \;

	# Fixup broken symlinks
	dosym gfilerunner /usr/share/evidence/icons/default
	dosym azundris /usr/share/evidence/themes/default
	
	dodoc AUTHORS ChangeLog NEWS README docs/*
}

