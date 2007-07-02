# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-1.2.1.ebuild,v 1.12 2007/07/02 15:15:21 peper Exp $

inherit qt3

IUSE="jack"

DESCRIPTION="Digital DJ tool using QT 3.x"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="mirror://sourceforge/mixxx/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

RDEPEND="$(qt_min_version 3.1)
	media-sound/madplay
	=sci-libs/fftw-2*
	media-libs/libogg
	media-libs/libvorbis
	dev-lang/perl
	media-libs/audiofile
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	cd ${S}/src
	cp ${FILESDIR}/mixxx.pro .
	./configure
	sed -i -e "s/CFLAGS *= -pipe -w -O2/CFLAGS   = ${CFLAGS} -w/" Makefile
	sed -i -e "s/CXXFLAGS *= -pipe -w -O2/CXXFLAGS   = ${CXXFLAGS} -w/" Makefile
	sed -i -e "s/-DUNIX_SHARE_PATH=.*\\\" -D__LIN/-DUNIX_SHARE_PATH=\\\\\"\/usr\/share\/mixxx\\\\\" -D__LIN/" Makefile
	sed -i -e "42i \
INSTALL_ROOT=${D}
" Makefile
	sed -i -e 's/COPY_FILE= \$\(COPY\) -p/COPY_FILE= $(COPY) -pr/' Makefile

	addpredict  ${QTDIR}/etc/settings

	make || die
}

src_install() {
	cd ${S}/src

	make install || die

	einfo
	einfo "Fixing permissions..."
	einfo

	chmod 644 ${D}/usr/share/doc/${PF}/*
	chmod 644 ${D}/usr/share/mixxx/midi/*
	chmod 644 ${D}/usr/share/mixxx/skins/outline/*
	chmod 644 ${D}/usr/share/mixxx/skins/outlineClose/*
	chmod 644 ${D}/usr/share/mixxx/skins/traditional/*
}
