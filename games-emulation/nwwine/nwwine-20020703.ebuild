# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/nwwine/nwwine-20020703.ebuild,v 1.2 2004/02/20 06:26:47 mr_bones_ Exp $

DESCRIPTION="A special version of wine for the Never Winter Nights toolkit"
HOMEPAGE="http://www.winehq.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc"
IUSE="nas arts cups opengl alsa tcltk debug"

DEPEND="sys-devel/gcc
	sys-devel/flex
	dev-util/yacc
	>=sys-apps/sed-4
	>=sys-libs/ncurses-5.2
	>=media-libs/freetype-2.0.0
	X? ( 	virtual/x11 )
	tcltk? ( dev-lang/tcl dev-lang/tk )
	arts? ( kde-base/arts )
	alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )
	cups? ( net-print/cups )
	opengl? ( virtual/opengl )"

src_compile() {
	# there's no configure flag for cups, arts, alsa and nas, it's supposed to be autodetected

	# use the default setting in ./configure over the /etc/make.conf setting
	unset CFLAGS CXXFLAGS

	./configure \
		--prefix=/usr/lib/${PN} \
		--sysconfdir=/etc/${PN} \
		--host=${CHOST} \
		--enable-curses \
		`use_enable opengl` \
		`use_enable debug trace` \
		`use_enable debug` \
		|| die "configure failed"

	sed -i -e 's:wine.pm:include/wine.pm:' ${S}/programs/winetest/Makefile || \
		die "sed programs/winetest/Makefile failed"

	# No parallel make
	make depend all || die "make depend all failed"
	cd programs && emake || die
}

src_install() {
	local WINEMAKEOPTS="prefix=${D}/usr/lib/${PN}"

	### Install wine to ${D}
	make ${WINEMAKEOPTS} install || die
	cd ${S}/programs
	make ${WINEMAKEOPTS} install || die

	# Needed for later installation
	dodir /usr/bin

	### Creation of /usr/lib/${PN}/.data
	# set up fake_windows
	dodir /usr/lib/${PN}/.data
	cd ${D}/usr/lib/nwwine/.data
	tar jxvf ${FILESDIR}/${P}-fake_windows.tar.bz2
	chown root:root fake_windows/ -R

	# unpack the miscellaneous files
	tar jxvf ${FILESDIR}/${P}-misc.tar.bz2
	chown root:root config

	# move wrappers to bin/
	insinto /usr/bin
	dobin regedit-nwwine nwwine
	rm regedit-nwwine nwwine

	# put winedefault.reg into .data
	insinto /usr/lib/${PN}/.data
	doins ${WORKDIR}/${P}/winedefault.reg

	# set up this dynamic data
	cd ${S}
	insinto /usr/lib/${PN}/.data/fake_windows/Windows
	doins documentation/samples/system.ini
	doins documentation/samples/generic.ppd
	## Setup of .data complete

	### Misc tasks
	# take care of the documentation
	cd ${S}
	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE README

	# manpage setup
	cp ${D}/usr/lib/${PN}/man/man1/wine.1 ${D}/usr/lib/${PN}/man/man1/${PN}.1
	doman ${D}/usr/lib/${PN}/man/man1/${PN}.1
	rm ${D}/usr/lib/${PN}/man/man1/${PN}.1

	# remove the executable flag from those libraries.
	cd ${D}/usr/lib/${PN}/lib/wine
	chmod a-x *.so
}

pkg_postinst() {
	einfo "Use /usr/bin/nwwine to start wine. This is a wrapper-script"
	einfo "which will take care of everything else."
	einfo ""
	einfo "Use /usr/bin/regedit-nwwine to import registry files into the"
	einfo "wine registry."
	einfo ""
	einfo "If you have further questions, enhancements or patches"
	einfo "send an email to phoenix@gentoo.org"
}
