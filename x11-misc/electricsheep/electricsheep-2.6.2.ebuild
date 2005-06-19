# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/electricsheep/electricsheep-2.6.2.ebuild,v 1.1 2005/06/19 07:25:15 dragonheart Exp $

inherit eutils flag-o-matic

DESCRIPTION="realize the collective dream of sleeping computers from all over the internet"
HOMEPAGE="http://electricsheep.org/"
SRC_URI="http://electricsheep.org/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"

DEPEND="virtual/x11
	dev-libs/expat
	sys-apps/groff
	dev-lang/perl
	>=sys-apps/sed-4
	media-libs/libmpeg2
	sys-apps/gawk
	sys-apps/grep
	sys-devel/libtool
	media-libs/jpeg
	media-libs/libpng
	media-libs/libsdl
	virtual/libc
	sys-libs/zlib
	!sparc? ( media-libs/alsa-lib )"

#
# I did a ldd /usr/bin/anim-flame /usr/bin/hqi-flame /usr/bin/pick-flame /usr/bin/convert-flame \
#   /usr/bin/mpeg2dec_onroot /usr/bin/electricsheep | cut -f3 -d ' ' | xargs -n 1 qpkg -f -v | sort | uniq
#
# on an x86 platform and it listed media-libs/svgalib as a dependancy (hard masked on sparc).
# I'm removing the dependancy on sparc as hopefully it will work without it.


RDEPEND="virtual/x11
	dev-libs/expat
	net-misc/curl
	media-gfx/xloadimage
	media-libs/jpeg
	media-libs/libpng
	media-libs/libsdl
	!sparc? ( media-libs/alsa-lib )
	virtual/libc
	sys-libs/zlib"

# Also detects and ties in sys-libs/slang, media-libs/aalib media-libs/svgalib and nas
# if they exist on the user machine although these aren't deps.

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:/usr/local/share:/usr/share/${PN}:" \
		electricsheep.c \
		|| die "sed electricsheep.c failed"
	sed -i '/OPT_CFLAGS=/s:=".*":="$CFLAGS":' \
		mpeg2dec/configure \
		|| die "sed mpeg2dec failed"
#	epatch ${FILESDIR}/nice.patch
	filter-flags -fPIC
}

src_install() {

	${D}/usr/bin/uniqueid > ${D}/usr/share/electricsheep/electricsheep-uniqueid

	# prevent writing for xscreensaver
	sed -i "s/^install-data-local:$/install-data-local:\nmy-install-data-local:/" \
		Makefile || die "sed Makefile failed"

	# install the xscreensaver config file
	insinto /usr/share/control-center/screensavers
	doins electricsheep.xml

	# install the main stuff ... flame doesn't create /usr/bin so we have to.
	dodir /usr/bin
	make install DESTDIR=${D} || die "make install failed"
	dodir /usr/share/electricsheep
	mv ${D}/usr/share/electricsheep-* ${D}/usr/share/electricsheep/

	# remove header files that are installed over libmpeg2
	rm -rf ${D}/usr/include
}

pkg_postinst()
{
	test -f ${ROOT}/usr/share/electricsheep/electricsheep-uniqueid || ${ROOT}/usr/bin/uniqueid > \
		${ROOT}/usr/share/electricsheep/electricsheep-uniqueid
}
