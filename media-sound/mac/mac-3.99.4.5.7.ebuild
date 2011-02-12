# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mac/mac-3.99.4.5.7.ebuild,v 1.3 2011/02/12 16:19:14 xarthisius Exp $

EAPI=2

inherit eutils flag-o-matic multilib versionator

MY_PV=$(version_format_string '$1.$2-u$3-b$4')
PATCH=s$(get_version_component_range 5)
MY_P=${PN}-${MY_PV}-${PATCH}

DESCRIPTION="Monkey's Audio Codecs"
HOMEPAGE="http://etree.org/shnutils/shntool/"
SRC_URI="http://etree.org/shnutils/shntool/support/formats/ape/unix/${MY_PV}-${PATCH}/${MY_P}.tar.gz"

LICENSE="mac"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="mmx"

RDEPEND=""
DEPEND="sys-apps/sed
	mmx? ( dev-lang/yasm )"

S=${WORKDIR}/${MY_P}

RESTRICT="mirror"

src_prepare() {
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
	dodoc AUTHORS ChangeLog* NEWS README TODO src/*.txt || die
	dohtml src/Readme.htm || die
	find "${D}"/usr/$(get_libdir) -name '*.la' -delete || die
}
