# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mac/mac-3.99.4.5.4.ebuild,v 1.1 2009/12/20 17:02:48 billie Exp $

EAPI=2

inherit eutils flag-o-matic multilib versionator

MY_PV=$(get_version_component_range 1-2)-u$(get_version_component_range 3)-b$(get_version_component_range 4)
PATCH=s$(get_version_component_range 5)
MY_P=${PN}-${MY_PV}-${PATCH}

DESCRIPTION="Monkey's Audio Codecs"
HOMEPAGE="http://etree.org/shnutils/shntool/"
SRC_URI="http://etree.org/shnutils/shntool/support/formats/ape/unix/${MY_PV}/${PATCH}/${MY_P}.tar.gz"

LICENSE="mac"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mmx"

RDEPEND=""
DEPEND="sys-apps/sed
	mmx? ( dev-lang/yasm )"

S=${WORKDIR}/${MY_P}

RESTRICT="mirror"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
	sed -i -e 's:-O3::' configure || die
}

pkg_setup() {
	append-cppflags -DSHNTOOL
	use mmx && append-ldflags -Wl,-z,noexecstack
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
	dodoc AUTHORS ChangeLog ChangeLog.shntool NEWS README TODO src/Credits.txt \
		src/History.txt || die
	dohtml src/Readme.htm || die
	find "${D}"/usr/$(get_libdir) -name '*.la' -delete || die
}
