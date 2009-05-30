# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vboxgtk/vboxgtk-0.4.1.ebuild,v 1.1 2009/05/30 15:58:44 volkmar Exp $

EAPI="2"

inherit eutils multilib python

DESCRIPTION="GTK frontend for VirtualBox"
HOMEPAGE="http://www.xente.mundo-r.com/narf/vboxgtk/"
SRC_URI="http://www.xente.mundo-r.com/narf/${PN}/releases/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( >=app-emulation/virtualbox-ose-2.1[-headless]
	>=app-emulation/virtualbox-bin-2.1[-headless] )
	dev-python/pygobject
	dev-python/pygtk"

src_prepare() {
	sed -i -e "s:\([^#]self.base_path = \).*:\1\"/usr/$(get_libdir)/${PN}/\":" \
		vboxgtk || die "sed failed"
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}
	doins -r *.py ${PN}.glade pixmaps/ || die "doins failed"

	exeinto /usr/$(get_libdir)/${PN}
	doexe ${PN} || die "doexe failed"

	dosym /usr/$(get_libdir)/${PN}/${PN} /usr/bin/${PN} || die "dosym failed"
	dosym /usr/$(get_libdir)/${PN}/pixmaps/48x48.png \
		/usr/share/pixmaps/${PN}.png || die "dosym failed"

	make_desktop_entry ${PN} "VBoxGtk" ${PN}.png
}

pkg_postinst() {
	python_mod_optimize "${ROOT}/usr/$(get_libdir)/${PN}"
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}/usr/$(get_libdir)/${PN}"
}
