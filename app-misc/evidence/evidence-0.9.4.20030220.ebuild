# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/evidence/evidence-0.9.4.20030220.ebuild,v 1.4 2003/03/10 11:15:45 vapier Exp $

DESCRIPTION="GTK2 file-manager"
HOMEPAGE="http://evidence.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="pic oggvorbis perl X"

#	gnome? ( >=gnome-base/gnome-vfs-2.0 >=gnome-base/libgnomecanvas-2.0 )
DEPEND=">=dev-util/pkgconfig-0.5
	=x11-libs/gtk+-2*
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	perl? ( dev-libs/libpcre )
	X? ( virtual/x11 )
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

src_compile() {
	env NOCONFIGURE=no WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"

	#causes compilation to fail: --enable-backend-script
	# has undefine constants
#	local gnomeconf
#	use gnome && gnomeconf="${myconf} --enable-backend-gnomevfs"
	econf \
		`use_with pic` \
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
	dodoc AUTHORS ChangeLog NEWS README docs/*
}
