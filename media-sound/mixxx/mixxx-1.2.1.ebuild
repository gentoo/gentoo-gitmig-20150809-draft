# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-1.2.1.ebuild,v 1.1 2004/01/28 04:30:19 raker Exp $

IUSE="jack"

DESCRIPTION="Digital DJ tool using QT 3.x"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="mirror://sourceforge/mixxx/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND="virtual/glibc
	>=x11-libs/qt-3.1.0
	media-sound/mad
	=dev-libs/fftw-2*
	media-libs/libogg
	media-libs/libvorbis
	dev-lang/perl
	media-libs/audiofile
	jack? ( virtual/jack )"

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

	addpredict  /usr/qt/3/etc/settings

	make || die
}

src_install() {
	cd ${S}/src

	make install || die

	einfo ""
	einfo "Fixing permissions..."
	einfo ""

	chmod 644 ${D}/usr/share/doc/${PF}/*
	chmod 644 ${D}/usr/share/mixxx/midi/*
	chmod 644 ${D}/usr/share/mixxx/skins/outline/*
	chmod 644 ${D}/usr/share/mixxx/skins/outlineClose/*
	chmod 644 ${D}/usr/share/mixxx/skins/traditional/*
}
