# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cacao/cacao-0.91.ebuild,v 1.2 2005/02/20 10:51:41 karltk Exp $

inherit eutils java-pkg

DESCRIPTION="Cacao Java Virtual Machine"
HOMEPAGE="http://www.cacaojvm.org/"
SRC_URI="http://www.complang.tuwien.ac.at/cacaojvm/download/cacao-${PV}/cacao-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk"
DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	for x in $(find . -name Makefile.in) ; do
		sed -r \
			-e "s:/jre/lib:/lib/cacao:" \
			-e "s:/jre/bin:/lib/cacao/bin:" \
			 -i $x || die "Failed to update paths"
	done
	sed -r \
		-e "s:(#define.*CACAO_LIBRARY_PATH).*:\1 \"/lib/cacao/\"ARCH_DIR\"/\":" \
		-e "s|(#define.*CACAO_RT_JAR_PATH).*|\1 \"/lib/cacao/rt.jar:\"|" \
		-i src/vm/global.h
}

src_compile() {
	econf `use_enable gtk gtk-peers` || die "Failed to configure"
	emake || die "Failed to compile"
}

src_install() {
	einstall || die "Failed to install"
}
