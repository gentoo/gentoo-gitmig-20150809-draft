# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cacao/cacao-0.91.ebuild,v 1.6 2005/07/18 11:14:48 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="Cacao Java Virtual Machine"
HOMEPAGE="http://www.cacaojvm.org/"
SRC_URI="http://www.complang.tuwien.ac.at/cacaojvm/download/cacao-${PV}/cacao-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gtk"
DEPEND="
	gtk? (
		>=x11-libs/gtk+-2.0
		>=dev-libs/atk-1.0
		>=x11-libs/pango-1.0
		>=dev-libs/glib-2.0
		>=media-libs/libart_lgpl-2.0
	)"
RDEPEND="${DEPEND}"

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
	econf $(use_enable gtk gtk-peer) || die "Failed to configure"
	emake || die "Failed to compile"
}

src_install() {
	einstall || die "Failed to install"
}
