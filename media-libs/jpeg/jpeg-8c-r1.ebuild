# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-8c-r1.ebuild,v 1.1 2011/12/25 11:26:15 grobian Exp $

EAPI="3"

DEB_PV="7-1"
DEB_PN="libjpeg7"
DEB="${DEB_PN}_${DEB_PV}"

inherit eutils libtool multilib

DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
HOMEPAGE="http://jpegclub.org/ http://www.ijg.org/"
SRC_URI="http://www.ijg.org/files/${PN}src.v${PV}.tar.gz
	mirror://gentoo/${DEB}.diff.gz"
#	mirror://debian/pool/main/libj/${DEB_PN}/${DEB}.diff.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"

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
		--disable-dependency-tracking \
		--enable-shared \
		$(use_enable static-libs static) \
		--enable-maxmem=64 \
		${ldverscript}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc change.log example.c README *.txt

	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
