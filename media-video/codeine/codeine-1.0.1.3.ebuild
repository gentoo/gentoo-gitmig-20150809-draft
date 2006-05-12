# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/codeine/codeine-1.0.1.3.ebuild,v 1.1 2006/05/12 13:36:07 flameeyes Exp $

inherit kde multilib versionator

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

DESCRIPTION="Simple KDE frontend for xine-lib."
HOMEPAGE="http://kde-apps.org/content/show.php?content=17161"
SRC_URI="http://www.methylblue.com/codeine/${PN}-$(replace_version_separator 3 -).tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/xine-lib"

DEPEND="${RDEPEND}
	dev-util/scons"

need-kde 3.3

src_compile(){
	local myconf="prefix=/usr"
	# Fix multilib issue.
	myconf="${myconf} libdir=/usr/$(get_libdir)
			qtlibs=${QTDIR}/$(get_libdir)"

	scons configure ${myconf} || die
	scons || die
}

src_install() {
	DESTDIR="${D}" scons install || die
	dodoc README ChangeLog VERSION
}
