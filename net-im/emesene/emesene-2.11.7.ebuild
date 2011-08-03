# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/emesene/emesene-2.11.7.ebuild,v 1.1 2011/08/03 13:30:45 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

GIT_COMMIT="0fe75b2"

MY_P="${PN}-${PN}-${GIT_COMMIT}"

inherit distutils eutils

DESCRIPTION="Platform independent MSN Messenger client written in Python+GTK"
HOMEPAGE="http://www.emesene.org"
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 )"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="jabber"

RDEPEND="dev-python/pygtk:2
	dev-python/papyon
	dev-python/notify-python
	jabber? ( dev-python/xmpppy )"

S="${WORKDIR}/${PN}-${PN}-${GIT_COMMIT}"

src_prepare() {
	# do not import dummy session
	sed -i -e  "/import e3dummy/d" ${PN}/${PN}.py || die
	# fix .desktop icon to look for emesene-2 executable
	sed -i -e "s:${PN}:${PN}-2:g" \
		${PN}/data/share/applications/${PN}.desktop || die
	# Use a better meny entry
	sed -i -e "/^Name/s:${PN}-2:Emesene v2:" \
		${PN}/data/share/applications/${PN}.desktop || die
	distutils_src_prepare
}

src_install() {
	mysymlink(){
		dosym  $(python_get_sitedir)/${PN}/${PN} /usr/bin/${PN}-2 || die
	}
	distutils_src_install
	# fix names
	mv "${D}"/usr/share/applications/${PN}.desktop \
		"${D}"/usr/share/applications/${PN}-2.desktop
	mv "${D}"/usr/share/pixmaps/${PN}.png \
		"${D}"/usr/share/pixmaps/${PN}-2.png
	mv "${D}"/usr/share/pixmaps/${PN}.xpm \
		"${D}"/usr/share/pixmaps/${PN}-2.xpm
	mv "${D}"/usr/share/man/man1/${PN}.1 \
		"${D}"/usr/share/man/man1/${PN}-2.1

	python_execute_function -q mysymlink
}
