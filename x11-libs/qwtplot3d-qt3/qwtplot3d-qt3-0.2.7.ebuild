# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwtplot3d-qt3/qwtplot3d-qt3-0.2.7.ebuild,v 1.3 2008/01/14 11:24:25 bicatali Exp $

inherit eutils multilib qt3

MY_PN=${PN%-qt3}

DESCRIPTION="Qt3/OpenGL-based 3D widget library for C++"
HOMEPAGE="http://qwtplot3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}.tgz"

LICENSE="ZLIB"
SLOT="0"
IUSE="doc examples"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="$(qt_min_version 3.3)"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${MY_PN}"

pkg_setup() {
	if ! built_with_use =x11-libs/qt-3* opengl; then
		eerror "You need to build x11-libs/qt with opengl use flag enabled."
		die
	fi
}

src_unpack () {
	unpack ${A}
	epatch "${FILESDIR}"/${MY_PN}-profile.patch
	epatch "${FILESDIR}"/${MY_PN}-examples.patch
	epatch "${FILESDIR}"/${MY_PN}-doxygen.patch
	sed -i -e "s:${MY_PN}:${PN}:g" ${MY_PN}/${MY_PN}.pro
}

src_compile () {
	cat >> ${MY_PN}.pro <<-EOF
		target.path = /usr/$(get_libdir)
		headers.path = /usr/include/${PN}
		headers.files = \$\$HEADERS
		INSTALLS = target headers
	EOF
	eqmake3 ${MY_PN}.pro || die "eqmake3 failed"
	emake || die "emake failed"
	if use doc; then
		cd doc
		doxygen Doxyfile.doxygen || die "doxygen failed"
	fi
}

src_install () {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "doins examples failed"
	fi
	use doc && dohtml -r doc/web/doxygen/*
}
