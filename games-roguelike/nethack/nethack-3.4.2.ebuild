# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/nethack/nethack-3.4.2.ebuild,v 1.6 2004/03/31 05:20:53 mr_bones_ Exp $

inherit eutils gcc flag-o-matic games

MY_PV=${PV//.}
DESCRIPTION="The ultimate old-school single player dungeon exploration game"
HOMEPAGE="http://www.nethack.org/"
SRC_URI="mirror://sourceforge/nethack/${PN}-${MY_PV}.tgz"
#SRC_URI="ftp://ftp.nethack.org/pub/nethack/nh340/src/nethack-340.tgz"

LICENSE="nethack"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="X qt gnome"

DEPEND="virtual/glibc
	dev-util/yacc
	>=sys-libs/ncurses-5.2-r5
	X? ( virtual/x11 )
	qt? ( x11-libs/qt )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.4-r2 )"

HACKDIR="${GAMES_DATADIR}/${PN}"

src_unpack() {
	append-flags -I../include
	unpack ${A}

	# This copies the /sys/unix Makefile.*s to their correct places for 
	# seding and compiling.
	cd ${S}/sys/unix
	source setup.sh || die

	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	epatch ${FILESDIR}/${PV}-errno.patch
	epatch ${FILESDIR}/${PV}-default-options.patch

	sed -i \
		-e "s:GENTOO_STATEDIR:${GAMES_STATEDIR}/${PN}:" include/unixconf.h \
			|| die "setting statedir"
	sed -i \
		-e "s:GENTOO_HACKDIR:${HACKDIR}:" include/config.h \
			|| die "seting hackdir"

	if use X ; then
		epatch ${FILESDIR}/${PV}-X-support.patch
		if use qt ; then
			epatch ${FILESDIR}/${PV}-QT-support.patch
			use gnome && epatch ${FILESDIR}/${PV}-QT-GNOME-support.patch
		elif use gnome ; then
			epatch ${FILESDIR}/${PV}-GNOME-support.patch
		fi
	fi
}

src_compile() {
	local qtver=
	has_version =x11-libs/qt-3* \
		&& qtver=3 \
		|| qtver=2
	cd ${S}/src

	make \
		QTDIR=/usr/qt/${qtver} \
		CC="$(gcc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LFLAGS="-L/usr/X11R6/lib" \
		|| die
	cd ${S}/util
	make CFLAGS="${CFLAGS}" recover || die
}

src_install() {
	make \
		CC="$(gcc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LFLAGS="-L/usr/X11R6/lib" \
		GAMEPERM=0755 \
		PREFIX=${D}/usr \
		GAMEDIR=${D}${HACKDIR} \
		SHELLDIR=${D}/${GAMES_BINDIR} \
		install \
			|| die "make install failed"
	newgamesbin util/recover recover-nethack

	# The final nethack is a sh script.  This fixes the hard-coded
	# HACKDIR directory so it doesn't point to ${D}/usr/share/nethackdir
	dosed "s:^\(HACKDIR=\).*:\1${HACKDIR}:" ${GAMES_BINDIR}/nethack

	doman doc/*.6
	dodoc doc/*.txt

	# Can be copied to ~/.nethackrc to set options
	# Add this to /etc/.skel as well, thats the place for default configs
	insinto ${HACKDIR}
	doins ${FILESDIR}/dot.nethackrc
	local windowtypes="tty"
	use gnome && windowtypes="${windowtypes} gnome"
	use qt && windowtypes="${windowtypes} qt"
	use X && windowtypes="${windowtypes} x11"
	set -- ${windowtypes}
	dosed "s:GENTOO_WINDOWTYPES:${windowtypes}:" ${HACKDIR}/dot.nethackrc
	dosed "s:GENTOO_DEFWINDOWTYPE:$1:" ${HACKDIR}/dot.nethackrc
	insinto /etc/skel
	newins ${D}/${HACKDIR}/dot.nethackrc .nethackrc

	if use X ; then
		# install nethack fonts
		cd ${S}/win/X11
		bdftopcf -o nh10.pcf nh10.bdf || die "Converting fonts failed"
		bdftopcf -o ibm.pcf ibm.bdf || die "Converting fonts failed"
		insinto ${HACKDIR}/fonts
		doins *.pcf
		cd ${D}/${HACKDIR}/fonts
		mkfontdir || die "The action mkfontdir ${D}${HACKDIR}/fonts failed"

		# copy nethack x application defaults
		cd ${S}/win/X11
		insinto /etc/X11/app-defaults
		newins NetHack.ad NetHack || die "Failed to install NetHack X app defaults"
		dosed 's:^!\(NetHack.tile_file.*\):\1:' /etc/X11/app-defaults/NetHack
	fi

	# make sure we dont overwrite previous settings #16428
	local statedir=${GAMES_STATEDIR}/${PN}
	dodir ${statedir}
	mv ${D}/${HACKDIR}/{record,logfile,perm} ${D}/${statedir}/
	for f in record logfile perm ; do
		[ ! -e ${statedir}/${f} ] && continue
		mv ${D}/${statedir}/${f}{,.sample}
	done
	keepdir ${statedir}/save

	prepgamesdirs
	chmod -R 660 ${D}/${statedir}
	chmod 770 ${D}/${statedir} ${D}/${statedir}/save
}

pkg_postinst() {
	games_pkg_postinst
	if use qt && has_version '=x11-libs/qt-3.1*' ; then
		ewarn "the qt frontend may be a little unstable with this version of qt"
		ewarn "please see Bug 32629 for more information"
	fi
	einfo "you may want to look at /etc/skel/.nethackrc for interesting options"
}
