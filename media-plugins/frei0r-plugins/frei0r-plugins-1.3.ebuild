# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/frei0r-plugins/frei0r-plugins-1.3.ebuild,v 1.4 2011/12/26 14:33:22 maekke Exp $

EAPI=4
inherit cmake-utils multilib

DESCRIPTION="A minimalistic plugin API for video effects"
HOMEPAGE="http://www.piksel.org/frei0r/"
SRC_URI="http://www.piksel.no/frei0r/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc x86 ~x86-fbsd"
IUSE="doc +facedetect +scale0tilt"

RDEPEND="facedetect? ( >=media-libs/opencv-2.3.0 )
	scale0tilt? ( >=media-libs/gavl-1.2.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${P/-plugins}

DOCS=( AUTHORS ChangeLog README TODO )

src_prepare() {
	cat <<-EOF > "${T}"/frei0r.pc
	Name: frei0r
	Description: ${DESCRIPTION}
	Version: ${PV}
	EOF

	local f=CMakeLists.txt

	sed -i \
		-e '/set(CMAKE_C_FLAGS/d' \
		-e "/LIBDIR.*frei0r-1/s:lib:$(get_libdir):" \
		${f}

	use facedetect || sed -i -e '/package.*OpenCV/d' ${f}
	use scale0tilt || sed -i -e '/modules.*gavl/d' ${f}
}

src_compile() {
	cmake-utils_src_compile

	if use doc; then
		pushd doc
		doxygen || die
		popd
	fi
}

src_install() {
	cmake-utils_src_install

	insinto /usr/$(get_libdir)/pkgconfig
	doins "${T}"/frei0r.pc

	use doc && dohtml -r doc/html
}
