# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/openmotif-2.2.3.ebuild,v 1.8 2005/02/04 23:31:31 hansmi Exp $

inherit eutils libtool flag-o-matic multilib

MY_P=${P/m/M}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Open Motif"
HOMEPAGE="http://www.motifzone.org/"
SRC_URI="ftp://ftp.motifzone.net/om${PV}/src/${MY_P}.tar.gz"

SLOT="0"
LICENSE="MOTIF"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~ppc-macos sparc x86"

PROVIDE="virtual/motif"

DEPEND="virtual/libc
	virtual/x11
	>=sys-apps/sed-4
	sys-devel/automake
	sys-devel/autoconf
	!virtual/motif"

RDEPEND="virtual/libc
	virtual/x11
	!virtual/motif"

pkg_setup() {
	# multilib includes don't work right in this package...
	[ -n "${ABI}" ] && append-flags "-I/usr/include/gentoo-multilib/${ABI}"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# various patches
	epatch ${FILESDIR}/${P}-mwm-configdir.patch
	epatch ${FILESDIR}/${P}-CAN-2004-0687-0688.patch.bz2
	epatch ${FILESDIR}/${P}-CAN-2004-0914.patch.bz2
	epatch ${FILESDIR}/${P}-CAN-2004-0914_sec8.patch
	epatch ${FILESDIR}/${P}-char_not_supported.patch
	epatch ${FILESDIR}/${P}-pixel_length.patch
	epatch ${FILESDIR}/${P}-popup_timeout.patch
	epatch ${FILESDIR}/${P}-XmResizeHashTable.patch
	epatch ${FILESDIR}/${P}-utf8.patch
	epatch ${FILESDIR}/${P}-no_demos.patch

	# autotool stuff
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.4

	libtoolize --force --copy
	aclocal || die
	automake --foreign || die
	autoconf || die
}


src_compile() {
	# get around some LANG problems in make (#15119)
	unset LANG

	# fails to copmile with -jx
	export MAKEOPTS="${MAKEOPTS} -j1"

	# bug #80421
	filter-flags -ftracer

	econf --with-x || die "configuration failed"

	emake || die "make failed, if you have lesstif installed removed it, compile openmotif and recompile lesstif"
}


src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# move system.mwmrc & create symlink & fix manpages
	dodir "/etc/X11/mwm"
	mv "${D}/usr/$(get_libdir)/X11/system.mwmrc" "${D}/etc/X11/mwm/system.mwmrc"
	dosym "/etc/X11/mwm" "/usr/$(get_libdir)/X11/mwm"

	list="/usr/share/man/man1/mwm.1 /usr/share/man/man4/mwmrc.4"
	for f in $list; do
		dosed 's:/usr/lib/X11/\(.*system\\&\.mwmrc\):/etc/X11/mwm/\1:g' "$f"
		dosed 's:/usr/lib/X11/app-defaults:/etc/X11/app-defaults:g' "$f"
	done

	# app-defaults/Mwm isn't included anymore as of 2.2
	insinto /etc/X11/app-defaults
	newins ${FILESDIR}/${P}-Mwm.defaults Mwm

	# remove unneeded files
	rm -fR ${D}/usr/$(get_libdir)/X11/bindings

	# install docs
	dodoc COPYRIGHT.MOTIF LICENSE
	dodoc README RELEASE RELNOTES
	dodoc BUGREPORT TODO
}

pkg_postinst() {
	ewarn "This breaks applications linked against libXm.so.2."
	ewarn "You have to rebuild these applications with revdep-rebuild."
}
