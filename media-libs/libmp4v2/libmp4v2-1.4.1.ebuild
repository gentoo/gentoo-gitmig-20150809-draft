# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmp4v2/libmp4v2-1.4.1.ebuild,v 1.13 2006/04/08 21:35:29 tester Exp $

inherit multilib eutils

DESCRIPTION="libmp4v2 extracted from mpeg4ip"
HOMEPAGE="http://www.mpeg4ip.net/"
SRC_URI="mirror://sourceforge/mpeg4ip/mpeg4ip-${PV}.tar.gz"
LICENSE="MPL-1.1"
SLOT="0"
IUSE=""

KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND=""
RDEPEND="!<media-video/mpeg4ip-1.4.1
	!<media-libs/faad2-2.0-r9"

S=${WORKDIR}/mpeg4ip-${PV}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/mpeg4ip-${PV}-disable-faac-test.patch
	epatch ${FILESDIR}/mpeg4ip-${PV}-disable-sdl-test.patch
}

src_compile() {

	cd ${S}

	./bootstrap --prefix=/usr \
		--host=${CHOST} \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--libdir=/usr/$(get_libdir) \
		--localstatedir=/var/lib \
		--disable-warns-as-err \
		--disable-server \
		--disable-player \
		--disable-mp4live \
		--disable-id3tags \
		--disable-xvid \
		--disable-a52dec \
		--disable-mad \
		--disable-mpeg2dec \
		--disable-srtp \
		--disable-mp3lame \
		--disable-faac \
		--disable-ffmpeg \
		--disable-x264 \
		--with-pic \
		${EXTRA_ECONF} || die "configure failed"

	cd ${S}/lib/mp4v2

	sed -i -e 's:SUBDIRS = . test util:SUBDIRS = .:' Makefile \
		 || die "sed failed"

	emake || die "emake failed"
}

src_install() {

	cd ${S}/lib/mp4v2

	make DESTDIR=${D} install || die

	dodoc README INTERNALS API_CHANGES TODO

	sed -i -e 's:"mpeg4ip.h":<libmp4v2/mpeg4ip.h>:' \
		${D}/usr/include/mp4.h || die "sed failed"

	dodir /usr/include/libmp4v2

	cp ${S}/include/mpeg4ip.h  ${D}/usr/include/libmp4v2/
	sed -i -e 's:mpeg4ip_config.h:libmp4v2/mpeg4ip_config.h:' \
		-e 's:"mpeg4ip_version.h":<libmp4v2/mpeg4ip_version.h>:' \
		 ${D}/usr/include/libmp4v2/mpeg4ip.h  || die "sed failed"

	cp ${S}/include/mpeg4ip_version.h  ${D}/usr/include/libmp4v2/
	cp ${S}/mpeg4ip_config.h ${D}/usr/include/libmp4v2/

}
