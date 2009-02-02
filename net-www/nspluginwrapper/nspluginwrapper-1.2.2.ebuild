# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/nspluginwrapper/nspluginwrapper-1.2.2.ebuild,v 1.1 2009/02/02 21:31:05 chutzpah Exp $

inherit eutils nsplugins multilib

DESCRIPTION="Netscape Plugin Wrapper - Load 32bit plugins on 64bit browser"
HOMEPAGE="http://www.gibix.net/projects/nspluginwrapper/"
SRC_URI="http://www.gibix.net/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	net-misc/curl
	app-emulation/emul-linux-x86-xlibs
	app-emulation/emul-linux-x86-gtklibs
	|| ( >=sys-apps/util-linux-2.13 sys-apps/setarch )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# bug #238403
	epatch "${FILESDIR}/${PN}-1.1.0-quiet-64bit-plugin-warnings.patch"
}

src_compile() {
	econf --with-biarch \
		--with-lib32=$(ABI=x86 get_libdir) \
		--with-lib64=$(get_libdir) \
		--pkglibdir=/usr/$(get_libdir)/${PN}

	emake || die "emake failed"

}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	inst_plugin "/usr/$(get_libdir)/${PN}/x86_64/linux/npwrapper.so"
	dosym "/usr/$(get_libdir)/${PN}/x86_64/linux/npconfig" "/usr/bin/${PN}"

	dodoc NEWS README TODO ChangeLog
}

pkg_postinst() {
	einfo "Auto installing 32bit plugins..."
	${PN} -a -i
	elog "Any 32bit plugins you currently have installed have now been"
	elog "configured to work in a 64bit browser. Any plugins you install in"
	elog "the future will first need to be setup with:"
	elog "  \"nspluginwrapper -i <path-to-32bit-plugin>\""
	elog "before they will function in a 64bit browser"
	elog
}

# this is terribly ugly, but without a way to query portage as to whether
# we are upgrading/reinstalling a package versus unmerging, I can't think of
# a better way

pkg_prerm() {
	einfo "Removing wrapper plugins..."
	${PN} --auto --remove
}

pkg_postrm() {
	if [[ -x /usr/bin/${PN} ]]; then
		einfo "Auto installing 32bit plugins..."
		${PN} --auto --install
	fi
}
