# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/nethack/nethack-3.4.3-r1.ebuild,v 1.6 2005/05/17 18:43:19 wolf31o2 Exp $

inherit eutils toolchain-funcs flag-o-matic games

MY_PV=${PV//.}
DESCRIPTION="The ultimate old-school single player dungeon exploration game"
HOMEPAGE="http://www.nethack.org/"
SRC_URI="mirror://sourceforge/nethack/${PN}-${MY_PV}-src.tgz"
#SRC_URI="ftp://ftp.nethack.org/pub/nethack/nh340/src/nethack-340.tgz"

LICENSE="nethack"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="X qt gnome"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2-r5
	X? ( virtual/x11 )
	qt? ( x11-libs/qt )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.4-r2 )"

HACKDIR="${GAMES_DATADIR}/${PN}"

src_unpack() {
	unpack ${A}

	# This copies the /sys/unix Makefile.*s to their correct places for
	# seding and compiling.
	cd "${S}/sys/unix"
	source setup.sh || die

	cd "${S}"
	epatch "${FILESDIR}/${PV}-gentoo-paths.patch"
	epatch "${FILESDIR}/${PV}-default-options.patch"
	epatch "${FILESDIR}/${PV}-bison.patch"

	sed -i \
		-e "s:GENTOO_STATEDIR:${GAMES_STATEDIR}/${PN}:" include/unixconf.h \
		|| die "setting statedir"
	sed -i \
		-e "s:GENTOO_HACKDIR:${HACKDIR}:" include/config.h \
		|| die "seting hackdir"
	# set the default pager from the environment bug #52122
	if [ -n "${PAGER}" ] ; then
		sed -i \
			-e "115c\#define DEF_PAGER \"${PAGER}\"" \
			include/unixconf.h \
			|| die "setting statedir"
		# bug #57410
		sed -i \
			-e "s/^DATNODLB =/DATNODLB = \$(DATHELP)/" Makefile \
			|| die "sed Makefile failed"
	fi

	if use X ; then
		epatch "${FILESDIR}/${PV}-X-support.patch"
		if use qt ; then
			epatch "${FILESDIR}/${PV}-QT-support.patch"
			use gnome && epatch "${FILESDIR}/${PV}-QT-GNOME-support.patch"
		elif use gnome ; then
			epatch "${FILESDIR}/${PV}-GNOME-support.patch"
		fi
	fi
}

src_compile() {
	local qtver=

	has_version =x11-libs/qt-3* \
		&& qtver=3 \
		|| qtver=2
	cd ${S}/src
	append-flags -I../include

	emake \
		QTDIR=/usr/qt/${qtver} \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LFLAGS="-L/usr/X11R6/lib" \
		../util/makedefs \
		|| die "initial makedefs build failed"
	emake \
		QTDIR=/usr/qt/${qtver} \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LFLAGS="-L/usr/X11R6/lib" \
		|| die "main build failed"
	cd ${S}/util
	emake CFLAGS="${CFLAGS}" recover || die "util build failed"
}

src_install() {
	make \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LFLAGS="-L/usr/X11R6/lib" \
		GAMEPERM=0755 \
		PREFIX="${D}/usr" \
		GAMEDIR="${D}${HACKDIR}" \
		SHELLDIR="${D}/${GAMES_BINDIR}" \
		install \
		|| die "make install failed"

	# We keep this stuff in ${GAMES_STATEDIR} instead so tidy up.
	rm -rf "${D}/usr/share/games/nethack/save"

	newgamesbin util/recover recover-nethack || die "newgamesbin failed"

	# The final nethack is a sh script.  This fixes the hard-coded
	# HACKDIR directory so it doesn't point to ${D}/usr/share/nethackdir
	sed -i \
		-e "s:^\(HACKDIR=\).*:\1${HACKDIR}:" \
		"${D}${GAMES_BINDIR}/nethack" \
		|| die "sed ${D}${GAMES_BINDIR}/nethack failed"

	doman doc/*.6
	dodoc doc/*.txt

	# Can be copied to ~/.nethackrc to set options
	# Add this to /etc/.skel as well, thats the place for default configs
	insinto "${HACKDIR}"
	doins "${FILESDIR}/dot.nethackrc"

	local windowtypes="tty"
	use gnome && windowtypes="${windowtypes} gnome"
	use qt && windowtypes="${windowtypes} qt"
	use X && windowtypes="${windowtypes} x11"
	set -- ${windowtypes}
	sed -i \
		-e "s:GENTOO_WINDOWTYPES:${windowtypes}:" \
		-e "s:GENTOO_DEFWINDOWTYPE:$1:" \
		"${D}${HACKDIR}/dot.nethackrc" \
		|| die "sed ${D}${HACKDIR}/dot.nethackrc failed"
	insinto /etc/skel
	newins "${D}/${HACKDIR}/dot.nethackrc" .nethackrc

	if use X ; then
		# install nethack fonts
		cd "${S}/win/X11"
		bdftopcf -o nh10.pcf nh10.bdf || die "Converting fonts failed"
		bdftopcf -o ibm.pcf ibm.bdf || die "Converting fonts failed"
		insinto "${HACKDIR}/fonts"
		doins *.pcf
		cd "${D}/${HACKDIR}/fonts"
		mkfontdir || die "The action mkfontdir ${D}${HACKDIR}/fonts failed"

		# copy nethack x application defaults
		cd "${S}/win/X11"
		insinto /etc/X11/app-defaults
		newins NetHack.ad NetHack || die "Failed to install NetHack X app defaults"
		sed -i \
			-e 's:^!\(NetHack.tile_file.*\):\1:' \
			"${D}/etc/X11/app-defaults/NetHack" \
			|| die "sed ${D}/etc/X11/app-defaults/NetHack failed"
	fi

	local statedir="${GAMES_STATEDIR}/${PN}"
	keepdir "${statedir}/save"
	mv "${D}/${HACKDIR}/"{record,logfile,perm} "${D}/${statedir}/"

	prepgamesdirs
	chmod -R 660 "${D}/${statedir}"
	chmod 770 "${D}/${statedir}" "${D}/${statedir}/save"
}

pkg_postinst() {
	games_pkg_postinst
	if use qt && has_version '=x11-libs/qt-3.1*' ; then
		ewarn "the qt frontend may be a little unstable with this version of qt"
		ewarn "please see Bug 32629 for more information"
	fi
	einfo "You may want to look at /etc/skel/.nethackrc for interesting options"
}
