# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ladspa-sdk/ladspa-sdk-1.0.ebuild,v 1.1 2002/06/10 02:10:03 rphillips Exp $

DESCRIPTION="The Linux Audio Developer's Simple Plugin API and some example plugins"
HOMEPAGE="http://www.ladspa.org/"
LICENSE="LGPL-2.1"
DEPEND="virtual/glibc"
SRC_URI="http://www.ladspa.org/download/ladspa_sdk.tgz"
S=${WORKDIR}/ladspa_sdk/src

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -e "/^CFLAGS/ s/-O3/${CFLAGS}/" < makefile > makefile.hacked
	mv makefile.hacked makefile
}

src_compile() {
	make targets || die
}

src_install() {
	make \
		INSTALL_PLUGINS_DIR=${D}/usr/lib/ladspa \
		INSTALL_INCLUDE_DIR=${D}/usr/include \
		INSTALL_BINARY_DIR=${D}/usr/bin \
		install || die

	dodoc ../doc/*
}

