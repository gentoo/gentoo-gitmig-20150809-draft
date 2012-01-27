# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-8c-r1.ebuild,v 1.5 2012/01/27 23:54:52 ssuominen Exp $

EAPI=4

DEB_PV=7-1
DEB_PN=libjpeg7
DEB="${DEB_PN}_${DEB_PV}"

inherit eutils libtool multilib

DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
HOMEPAGE="http://jpegclub.org/ http://www.ijg.org/"
SRC_URI="http://www.ijg.org/files/${PN}src.v${PV}.tar.gz
	mirror://gentoo/${DEB}.diff.gz"
#	mirror://debian/pool/main/libj/${DEB_PN}/${DEB}.diff.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"

DOCS="change.log example.c README *.txt"

src_prepare() {
	epatch "${WORKDIR}"/${DEB}.diff
	epatch "${FILESDIR}"/${PN}-7-maxmem_sysconf.patch
	cp "${FILESDIR}"/Makefile.in.extra debian/extra/Makefile.in
	elibtoolize
	# hook the Debian extra dir into the normal jpeg build env
	sed -i '/all:/s:$:\n\t./config.status --file debian/extra/Makefile\n\t$(MAKE) -C debian/extra $@:' Makefile.in
}

src_configure() {
	# unbreak compilation against this library on Solaris, same issue as on
	# DragonFly BSD:
	# http://mail-index.netbsd.org/pkgsrc-bugs/2010/01/18/msg035644.html
	local ldverscript=
	[[ ${CHOST} == *-solaris* ]] && ldverscript="--disable-ld-version-script"
	econf \
		--enable-shared \
		$(use_enable static-libs static) \
		--enable-maxmem=64 \
		${ldverscript}
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	ewarn "If you are switching from media-libs/libjpeg-turbo you might need to"
	ewarn "rebuild reverse dependencies:"
	ewarn
	ewarn "# emerge gentoolkit"
	ewarn "# revdep-rebuild --library libjpeg.so.8"
	ewarn
	ewarn "NOTE: The --library argument is important here."
}
