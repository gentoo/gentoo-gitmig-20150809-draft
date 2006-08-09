# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak/squeak-3.7.7-r1.ebuild,v 1.1 2006/08/09 14:01:15 araujo Exp $

inherit base versionator fixheadtails eutils

MY_PV=$(replace_version_separator 2 '-')
DESCRIPTION="Highly-portable Smalltalk-80 implementation"
HOMEPAGE="http://www.squeak.org/"
SRC_URI="http://squeakvm.org/unix/release/Squeak-${MY_PV}.src.tar.gz"
LICENSE="Apple"
SLOT="0"
KEYWORDS="~x86"
IUSE="X mmx threads iconv"

DEPEND="dev-libs/libffi
	( || ( ( x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXt )
	virtual/x11 ) )"
RDEPEND="${DEPEND}
	virtual/squeak-image"

S="${WORKDIR}/Squeak-${MY_PV}"

src_unpack() {
	base_src_unpack
	cd ${S}
	ht_fix_all
}

src_compile() {
	local myconf=""
	use X || myconf="--without-x"
	use mmx && myconf="${myconf} --enable-mpg-mmx"
	use threads && myconf="${myconf} --enable-mpg-pthread"
	use iconv || myconf="${myconf} --disable-iconv"
	cd ${S}
	mkdir build
	cd build
	../platforms/unix/config/configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-ffi=x86-sysv \
		${myconf} || die "configure failed"
	emake || die
}

src_install() {
	cd ${S}/build
	make ROOT=${D} docdir=/usr/share/doc/${PF} install || die
	exeinto /usr/lib/squeak
	doexe inisqueak
	dosym /usr/lib/squeak/inisqueak /usr/bin/inisqueak
}

pkg_postinst() {
	einfo "Run 'inisqueak' to get a private copy of the squeak image."
}
