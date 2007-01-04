# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/nspluginwrapper/nspluginwrapper-0.9.91.2.ebuild,v 1.1 2007/01/04 00:17:53 chutzpah Exp $

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
	app-emulation/emul-linux-x86-gtklibs
	sys-apps/setarch"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# I don't know how to get rid of these textrels
QA_TEXTRELS_amd64="usr/$(get_libdir)/nspluginwrapper/i386/npviewer.bin"

src_compile() {
	econf --with-biarch \
		--with-lib32=$(ABI=x86 get_libdir) \
		--with-lib64=$(get_libdir) \
		--pkglibdir=/usr/$(get_libdir)/${PN} || die
	emake || die
}

src_install() {
	emake -j1 DESTDIR="${D}" DONT_STRIP=yes install || die

	inst_plugin /usr/$(get_libdir)/nspluginwrapper/x86_64/linux/npwrapper.so
	dosym /usr/$(get_libdir)/nspluginwrapper/x86_64/linux/npconfig /usr/bin/nspluginwrapper

	dodoc NEWS README TODO ChangeLog
}

pkg_postinst() {
	einfo "Auto installing 32bit plugins..."
	nspluginwrapper -a -i
	einfo "Any 32bit plugins you currently have installed have now been"
	einfo "configured to work in a 64bit browser. Any plugins you install in"
	einfo "the future will first need to be setup with:"
	einfo "  \"nspluginwrapper -i <path-to-32bit-plugin>\""
	einfo "before they will function in a 64bit browser"
	einfo
}

# this is terribly ugly, but without a way to query portage as to whether
# we are upgrading/reinstalling a package versus unmerging, I can't think of
# a better way

pkg_prerm() {
	einfo "Removing wrapper plugins..."
	nspluginwrapper -a -r
}

pkg_postrm() {
	if [[ -x /usr/bin/nspluginwrapper ]]; then
		einfo "Auto installing 32bit plugins..."
		nspluginwrapper -a -i
	fi
}
