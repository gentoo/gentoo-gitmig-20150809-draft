# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tunapie/tunapie-2.1.17.ebuild,v 1.1 2009/04/30 09:58:26 ssuominen Exp $

EAPI=2
inherit eutils multilib python

DESCRIPTION="Directory browser for Radio and TV streams"
HOMEPAGE="http://tunapie.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="offensive"

RDEPEND=">=dev-python/wxpython-2.6"
DEPEND=""

src_prepare() {
	sed -i -e "s:/usr/local/share:/usr/$(get_libdir):" ${PN} \
		|| die "sed failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman ${PN}.1
	dodoc CHANGELOG README

	doicon src/tplogo.xpm
	domenu ${PN}.desktop

	insinto /usr/$(get_libdir)/${PN}
	doins src/{*.py,*.png} || die "doins failed"

	dodir /etc

	if use offensive; then
		echo 1 > "${D}"/etc/${PN}.config
	else
		echo 0 > "${D}"/etc/${PN}.config
	fi
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
}
