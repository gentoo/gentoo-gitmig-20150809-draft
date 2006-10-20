# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/nspluginwrapper/nspluginwrapper-0.9.90.3.ebuild,v 1.1 2006/10/20 01:20:16 chutzpah Exp $

inherit nsplugins flag-o-matic multilib

DESCRIPTION="Netscape Plugin Wrapper - Load 32bit plugins on 64bit browser"
HOMEPAGE="http://www.gibix.net/projects/nspluginwrapper/"
SRC_URI="http://www.gibix.net/projects/nspluginwrapper/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	app-emulation/emul-linux-x86-xlibs
	sys-apps/setarch"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!app-admin/eselect-compiler"

TARGET_CPU="i386"
TARGET_ABI="x86"

# I don't know how to get rid of these textrels
QA_TEXTRELS_amd64="usr/$(get_libdir)/nspluginwrapper/i386/npviewer.bin"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	append-flags "-std=c99"

	./configure \
		--prefix=/usr \
		--with-lib=$(get_libdir) \
		--with-cc=$(tc-getCC) \
		--target-cpu=${TARGET_CPU} || die
	emake || die

	mkdir build-${TARGET_CPU}-linux
	cd build-${TARGET_CPU}-linux
	ABI="${TARGET_ABI}" linux32 ../configure \
		--prefix=/usr \
		--with-lib=$(get_libdir) \
		--with-cc=$(tc-getCC) \
		--target-cpu=${TARGET_CPU} || die
	ABI="${TARGET_ABI}" linux32 emake npviewer.bin || die
}

src_install() {
	emake DESTDIR="${D}" DONT_STRIP=yes install || die

	cd build-${TARGET_CPU}-linux
	ABI="${TARGET_ABI}" emake DESTDIR="${D}" DONT_STRIP=yes install.viewer || die
	cd "${S}"

	inst_plugin /usr/lib/nspluginwrapper/x86_64/npwrapper.so
	dosym /usr/lib/nspluginwrapper/x86_64/npconfig /usr/bin/nspluginwrapper

	dodoc NEWS README TODO
}

pkg_postinst() {
	einfo "Auto installing 32bit plugins"
	nspluginwrapper -v -a -i
	einfo "Any 32bit plugins you currently have installed have now been"
	einfo "configured to work in a 64bit browser. Any plugins you install in"
	einfo "the future will first need to be setup with:"
	einfo "  \"nspluginwrapper -i <path-to-32bit-plugin>\""
	einfo "before they will function in a 64bit browser"
}

# this is terribly ugly, but without a way to query portage as to whether
# we are upgrading/reinstalling a package versus unmerging, I can't think of
# a better way

pkg_prerm() {
	einfo "Removing wrapper plugins"
	nspluginwrapper -v -a -r
}

pkg_postrm() {
	if has_version "${CATEGORY}/${PN}"; then
		einfo "Auto installing 32bit plugins"
		nspluginwrapper -v -a -i
	fi
}
