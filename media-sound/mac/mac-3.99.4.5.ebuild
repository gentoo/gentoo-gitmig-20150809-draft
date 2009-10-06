# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mac/mac-3.99.4.5.ebuild,v 1.1 2009/10/06 14:13:16 ssuominen Exp $

EAPI=2
inherit eutils multilib versionator

MY_P=${PN}-$(get_version_component_range 1-2)-u$(get_version_component_range 3)-b$(get_version_component_range 4)

DESCRIPTION="Monkey's Audio Codecs"
HOMEPAGE="http://supermmx.org/linux/mac/"
SRC_URI="http://supermmx.org/resources/linux/${PN}/${MY_P}.tar.gz"

LICENSE="mac"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mmx"

RDEPEND=""
DEPEND="sys-apps/sed
	mmx? ( dev-lang/yasm )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
	sed -i -e 's:-O3::' configure || die
}

src_configure() {
	local mmx=no
	use mmx && mmx=yes

	econf \
		--disable-dependency-tracking \
		--disable-static \
		--enable-assembly=${mmx}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO src/*.txt
	dohtml src/Readme.htm
	find "${D}"/usr/$(get_libdir) -name '*.la' -delete
}
