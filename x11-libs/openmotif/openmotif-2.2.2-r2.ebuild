# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/openmotif-2.2.2-r2.ebuild,v 1.2 2003/06/07 03:23:28 seemant Exp $

inherit libtool

MY_P=${P/m/M}
S=${WORKDIR}/${MY_P}
DESCRIPTION="OpenMotif is a defacto standard graphical user interface on Unix and Unix-like systems"
HOMEPAGE="http://www.motifzone.org/"
SRC_URI="ftp://ftp.sgi.com/other/motifzone/2.2/src/${MY_P}.tar.gz"

SLOT="0"
LICENSE="MOTIF"
KEYWORDS="x86 ppc ~sparc alpha"

PROVIDE="virtual/motif"

DEPEND="virtual/glibc
	virtual/x11"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/animate-demo.diff
	epatch ${FILESDIR}/include-order.diff
}

src_compile() {
	elibtoolize

	# get around some LANG problems in make (#15119)
	unset LANG
	
	econf \
		--prefix=/usr/X11R6 \
		--sysconfdir=/etc/X11 \
		--with-x \
		--with-gnu-ld || die

	make || die "make failed"
}

src_install() {

	make DESTDIR=${D} VARDIR=${D}/var/X11/ install || die "install failed"

	prepman /usr/X11R6

	#
	# patch manpages to reflect actual location of configuration files
	#
	einfo "fixing manpages..."
	list="/usr/X11R6/man/man1/mwm.1 /usr/X11R6/man/man4/mwmrc.4"
	for f in $list; do
		einfo "    ...${D}/$f"
		dosed 's:/usr/X11R6/lib/X11/\(.*system\\&\.mwmrc\):/etc/X11/mwm/\1:g' \
			"$f"
		dosed 's:/usr/X11R6/lib/X11/app-defaults:/etc/X11/app-defaults:g' \
			"$f"
	done
	unset f list


	# Move the system.mwmrc and create symlink
	dodir /etc/X11/mwm
	mv ${D}/usr/X11R6/lib/X11/mwm/system.mwmrc $D}/etc/X11/mwm
	dosym ../../../../etc/X11/mwm/system.mwmrc /usr/X11R6/lib/X11/mwm
	

	# upstream does not include an app-defaults/Mwm file any longer with
	# 2.2.2
	insinto /etc/X11/app-defaults
	newins ${FILESDIR}/Mwm.defaults Mwm

	dodoc COPYRIGHT* LICENSE* RE* *BUG*
}
