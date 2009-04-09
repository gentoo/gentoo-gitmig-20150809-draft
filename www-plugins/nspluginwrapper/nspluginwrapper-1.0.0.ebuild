# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/nspluginwrapper/nspluginwrapper-1.0.0.ebuild,v 1.1 2009/04/09 21:06:33 ulm Exp $

inherit eutils nsplugins flag-o-matic multilib

DESCRIPTION="Netscape Plugin Wrapper - Load 32bit plugins on 64bit browser"
HOMEPAGE="http://www.gibix.net/projects/nspluginwrapper/"
SRC_URI="http://www.gibix.net/projects/nspluginwrapper/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	app-emulation/emul-linux-x86-xlibs
	app-emulation/emul-linux-x86-gtklibs
	|| ( >=sys-apps/util-linux-2.13 sys-apps/setarch )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

autoinstall() {
	if [[ -x /usr/bin/${PN} ]]; then
		einfo "Auto installing 32bit plugins..."
		${PN} -a -i
		ls /usr/lib64/nsbrowser/plugins

		# Remove wrappers if equivalent 64-bit plugins exist
		# TODO: May be better to patch nspluginwrapper so it doesn't create
		#       duplicate wrappers in the first place...
		local DIR64="${ROOT}/usr/lib64/nsbrowser/plugins/"
		for f in "${DIR64}"/npwrapper.*.so; do
			local PLUGIN=${f##*/npwrapper.}
			if [[ -f ${DIR64}/${PLUGIN} ]]; then
				einfo "  Removing duplicate wrapper for native 64-bit ${PLUGIN}"
				${PN} -r "${f}"
			fi
		done
	fi
}

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
	autoinstall
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
	nspluginwrapper -a -r
}

pkg_postrm() {
	autoinstall
}
