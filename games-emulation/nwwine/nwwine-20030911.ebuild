# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/nwwine/nwwine-20030911.ebuild,v 1.5 2004/10/31 05:10:22 vapier Exp $

inherit eutils

DESCRIPTION="A special version of wine for the Neverwinter Nights toolkit"
HOMEPAGE="http://www.winehq.com/ http://republika.pl/nwnlinux/"
SRC_URI="mirror://gentoo/nwwine-20030618-misc.tar.bz2
	ftp://128.173.184.249/Linux/nwwine/nwwine-based-on-${PV}.tar.gz
	mirror://gentoo/nwwine-20030618-fake_windows.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE="X alsa arts cups debug nas opengl tcltk"

S=${WORKDIR}/nwwine-based-on-${PV}

DEPEND="sys-devel/gcc
	sys-devel/flex
	dev-util/yacc
	>=sys-libs/ncurses-5.2
	>=media-libs/freetype-2.0.0
	X? ( 	virtual/x11 )
	tcltk? ( dev-lang/tcl dev-lang/tk )
	arts? ( kde-base/arts )
	alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )
	cups? ( net-print/cups )
	opengl? ( virtual/opengl )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i '/^wine /s:wine:/usr/lib/nwwine/bin/wine:' nwwine.sh
	epatch ${FILESDIR}/winearts-kdecvs-fix.patch
	epatch ${FILESDIR}/wine-alsa.patch
}

src_compile() {
	# use the default setting in ./configure over the /etc/make.conf setting
	env -u CFLAGS -u CXXFLAGS \
		./configure \
		--prefix=/usr/lib/${PN} \
		--sysconfdir=/etc/${PN} \
		--host=${CHOST} \
		--enable-curses \
		`use_enable opengl` \
		`use_enable debug trace` \
		`use_enable debug` \
		${myconf} \
		|| die "configure failed"

	# No parallel make
	emake -j1 depend all || die "make depend all failed"
	cd programs && emake || die "emake failed"
}

src_install () {
	local WINEMAKEOPTS="prefix=${D}/usr/lib/${PN}"

	### Install wine to ${D}
	cd ${S}
	make ${WINEMAKEOPTS} install || die
	cd ${S}/programs
	make ${WINEMAKEOPTS} install || die

	# Needed for later installation
	dodir /usr/bin

	### Creation of /usr/lib/${PN}/.data
	# set up fake_windows
	dodir /usr/lib/${PN}/.data
	cd ${D}/usr/lib/nwwine/.data
	cp -r ${WORKDIR}/fake_windows .

	# copy config
	cp ${WORKDIR}/config .

	# put winedefault.reg into .data
	cp ${S}/winedefault.reg .

	# move wrappers to bin/
	cd ${WORKDIR}
	insinto /usr/bin
	dobin regedit-nwwine nwwine
	rm regedit-nwwine nwwine

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
	mv ${D}/usr/lib/${PN}/man/man1/wine.1 ${D}/usr/lib/${PN}/man/man1/${PN}.1
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
	einfo "If you have bugs, enhancements or patches"
	einfo "report a bug and assign it to wine@gentoo.org"
}
