# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/libvte-java/libvte-java-0.12.1-r1.ebuild,v 1.1 2006/12/17 13:41:28 betelgeuse Exp $

inherit java-gnome autotools

DESCRIPTION="Java bindings for vte"

SLOT="0.12"
KEYWORDS="~amd64 ~ppc ~x86"

DEPS=">=dev-java/libgtk-java-2.8.1
		>=x11-libs/vte-0.12.1"
DEPEND="${DEPS}"
RDEPEND="${DEPS}"

src_unpack() {
	unpack ${A}
	cd ${S}
	# patch to fix JNI compilation. should be fixed with next upstream release
	epatch ${FILESDIR}/${P}-jni_includes.patch
	# fix bug in install-data-hook which doesn't respect jardir
	epatch ${FILESDIR}/${P}-jardir.patch
}
