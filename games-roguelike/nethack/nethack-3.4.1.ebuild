# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/nethack/nethack-3.4.1.ebuild,v 1.1 2003/09/10 04:59:58 vapier Exp $

inherit games eutils flag-o-matic
append-flags -fomit-frame-pointer -I../include

MY_PV=${PV//.}

DESCRIPTION="The ultimate old-school single player dungeon exploration game"
HOMEPAGE="http://www.nethack.org/"
SRC_URI="mirror://sourceforge/nethack/${PN}-${MY_PV}.tgz"
#SRC_URI="ftp://ftp.nethack.org/pub/nethack/nh340/src/nethack-340.tgz"

KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="nethack"
IUSE="X qt gnome"

DEPEND="virtual/glibc
	dev-util/yacc
	>=sys-libs/ncurses-5.2-r5
	X? ( x11-base/xfree )
	qt? ( =x11-libs/qt-2* )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.4-r2 )"

HACKDIR=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}

	# This copies the /sys/unix Makefile.*s to their correct places for 
	# seding and compiling.
	cd ${S}/sys/unix
	source setup.sh || die

	cd ${S}
	epatch ${FILESDIR}/${PV}-errno.patch
	epatch ${FILESDIR}/${PV}-GNOME-RTLD_NEXT.patch
	epatch ${FILESDIR}/${PV}-default-options.patch

	cp ${S}/include/config.h{,.orig}
	sed -e "s:GENTOO_HACKDIR:${HACKDIR}:" \
		${S}/include/config.h.orig > ${S}/include/config.h

	if [ `use X` ] ; then
		epatch ${FILESDIR}/${PV}-X-support.patch
		if [ `use qt` ] ; then
			epatch ${FILESDIR}/${PV}-QT-support.patch
			[ `use gnome` ] && epatch ${FILESDIR}/${PV}-QT-GNOME-support.patch
		elif [ `use gnome` ] ; then
			epatch ${FILESDIR}/${PV}-GNOME-support.patch
		fi
	fi
}

src_compile() {
	cd ${S}/src
	make \
		QTDIR=/usr/qt/2 \
		CC="${CC:-gcc}" \
		CFLAGS="${CFLAGS}" \
		LFLAGS="-L/usr/X11R6/lib" \
		|| die
	cd ${S}/util
	make CFLAGS="${CFLAGS}" recover || die
}

src_install() {
	make \
		CC="${CC:-gcc}" \
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
	[ `use gnome` ] && windowtypes="${windowtypes} gnome"
	[ `use qt` ] && windowtypes="${windowtypes} qt"
	[ `use X` ] && windowtypes="${windowtypes} x11"
	set -- ${windowtypes}
	dosed "s:GENTOO_WINDOWTYPES:${windowtypes}:" ${HACKDIR}/dot.nethackrc
	dosed "s:GENTOO_DEFWINDOWTYPE:$1:" ${HACKDIR}/dot.nethackrc
	insinto /etc/skel
	newins ${D}/${HACKDIR}/dot.nethackrc .nethackrc

	if [ `use X` ] ; then
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

	keepdir /usr/share/games/nethack/save

	# make sure we dont overwrite previous settings #16428
	for f in record logfile perm ; do
		[ ! -e ${HACKDIR}/${f} ] && continue
		mv ${D}/${HACKDIR}/${f}{,.sample}
	done

	prepgamesdirs
}

pkg_postinst() {
	touch ${HACKDIR}/{record,logfile,perm}
	einfo "you may want to look at /etc/skel/.nethackrc for interesting options"
	games_pkg_postinst
}
