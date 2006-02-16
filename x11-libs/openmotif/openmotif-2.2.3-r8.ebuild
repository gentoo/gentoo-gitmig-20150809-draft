# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/openmotif-2.2.3-r8.ebuild,v 1.9 2006/02/16 19:49:58 grobian Exp $

inherit eutils libtool flag-o-matic multilib

MY_P=${P/m/M}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Open Motif"
HOMEPAGE="http://www.motifzone.org/"
SRC_URI="ftp://ftp.motifzone.net/om${PV}/src/${MY_P}.tar.gz"

LICENSE="MOTIF"
SLOT="2.2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc-macos ppc64 sh sparc x86"
IUSE=""

RDEPEND="virtual/libc
	|| ( ( x11-libs/libXmu
			x11-libs/libXaw
			x11-libs/libXp
		)
		virtual/x11
	)
	>=x11-libs/motif-config-0.9"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	!ppc-macos? ( =sys-devel/automake-1.4* )
	=sys-devel/autoconf-2.5*
	|| ( ( x11-proto/printproto
			x11-proto/xextproto
			x11-misc/xbitmaps
		)
		virtual/x11
	)"

PROVIDE="virtual/motif"

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
	epatch ${FILESDIR}/${P}-CAN-2004-0914-newer.patch.bz2
	epatch ${FILESDIR}/${P}-CAN-2004-0914_sec8.patch
	epatch ${FILESDIR}/${P}-char_not_supported.patch
	epatch ${FILESDIR}/${P}-pixel_length.patch
	epatch ${FILESDIR}/${P}-popup_timeout.patch
	epatch ${FILESDIR}/${P}-XmResizeHashTable.patch
	epatch ${FILESDIR}/${P}-utf8.patch
	epatch ${FILESDIR}/${P}-no_demos.patch
	epatch ${FILESDIR}/${P}-CVE-2005-3964.patch
	use ppc-macos && epatch ${FILESDIR}/${P}-automake.patch
	epatch ${FILESDIR}/CAN-2005-0605.patch

	# autotool stuff
	export WANT_AUTOCONF=2.5

	# Patched Makefile.am to work with version 1.6 on ppc-macos.
	# Untested elsewhere
	use ppc-macos || export WANT_AUTOMAKE=1.4

	libtoolize --force --copy
	aclocal || die
	AUTOMAKE_OPTS="--foreign"
	# For some reason ppc-macos complains about missing depcomp and compile
	# files
	use ppc-macos && AUTOMAKE_OPTS="-a -c -f ${AUTOMAKE_OPTS}"
	automake ${AUTOMAKE_OPTS} || die
	autoconf || die
}


src_compile() {
	# get around some LANG problems in make (#15119)
	unset LANG

	# bug #80421
	filter-flags -ftracer

	econf --with-x || die "configuration failed"

	emake -j1 || die "make failed, if you have lesstif installed removed it, compile openmotif and recompile lesstif"
}


src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# cleanups
	rm -fR ${D}/usr/$(get_libdir)/X11
	rm -fR ${D}/usr/$(get_libdir)/X11/bindings
	rm -fR ${D}/usr/include/X11/

	list="/usr/share/man/man1/mwm.1 /usr/share/man/man4/mwmrc.4"
	for f in $list; do
		dosed 's:/usr/lib/X11/\(.*system\\&\.mwmrc\):/etc/X11/mwm/\1:g' "$f"
		dosed 's:/usr/lib/X11/app-defaults:/etc/X11/app-defaults:g' "$f"
	done


	einfo "Fixing binaries"
	dodir /usr/$(get_libdir)/openmotif-2.2
	for file in `ls ${D}/usr/bin`
	do
		mv ${D}/usr/bin/${file} ${D}/usr/$(get_libdir)/openmotif-2.2/${file}
	done

	einfo "Fixing libraries"
	mv ${D}/usr/$(get_libdir)/* ${D}/usr/$(get_libdir)/openmotif-2.2/

	einfo "Fixing includes"
	dodir /usr/include/openmotif-2.2/
	mv ${D}/usr/include/* ${D}/usr/include/openmotif-2.2

	einfo "Fixing man pages"
	mans="1 3 4 5"
	for man in $mans; do
		dodir /usr/share/man/man${man}
		for file in `ls ${D}/usr/share/man/man${man}`
		do
			file=${file/.${man}/}
			mv ${D}/usr/share/man/man$man/${file}.${man} ${D}/usr/share/man/man${man}/${file}-openmotif-2.2.${man}
		done
	done

	# install docs
	dodoc README RELEASE RELNOTES BUGREPORT TODO

	# profile stuff
	dodir /etc/env.d
	echo "LDPATH=/usr/lib/openmotif-2.2" > ${D}/etc/env.d/15openmotif-2.2
	dodir /usr/$(get_libdir)/motif
	echo "PROFILE=openmotif-2.2" > ${D}/usr/$(get_libdir)/motif/openmotif-2.2
}

pkg_postinst() {
	/usr/bin/motif-config -s
}

pkg_postrm() {
	/usr/bin/motif-config -s
}
