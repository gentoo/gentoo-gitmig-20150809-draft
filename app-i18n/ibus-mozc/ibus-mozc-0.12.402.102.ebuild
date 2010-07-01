# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-mozc/ibus-mozc-0.12.402.102.ebuild,v 1.1 2010/07/01 22:59:02 matsuu Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils multilib python toolchain-funcs

MY_P="${P/ibus-}"
DESCRIPTION="The Mozc engine for IBus Framework"
HOMEPAGE="http://code.google.com/p/mozc/"
SRC_URI="http://mozc.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ibus scim qt4"

RDEPEND="dev-libs/glib:2
	dev-libs/protobuf
	net-misc/curl
	sys-libs/zlib
	ibus? ( >=app-i18n/ibus-1.2 )
	scim? ( app-i18n/scim )
	qt4? ( x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}
	dev-util/gtest
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

BUILDTYPE="${BUILDTYPE:-Release}"

RESTRICT="test"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	sed -i -e "s:/usr/lib/mozc:${EPREFIX}/usr/$(get_libdir)/mozc:" base/util.cc || die
	epatch "${FILESDIR}/${PN}-0.11.365.102-gentoo.patch"
}

src_configure() {
	"$(PYTHON)" build_mozc.py gyp || die "gyp failed"
}

src_compile() {
	tc-export CC CXX AR AS RANLIB LD
	export QTDIR="${EPREFIX}/usr"

	local mytarget="server/server.gyp:mozc_server"
	use ibus && mytarget="${mytarget} unix/ibus/ibus.gyp:ibus_mozc"
	use scim && mytarget="${mytarget} unix/scim/scim.gyp:scim_mozc unix/scim/scim.gyp:scim_mozc_setup"
	use qt4 && mytarget="${mytarget} gui/gui.gyp:mozc_tool"

	"$(PYTHON)" build_mozc.py build_tools -c "${BUILDTYPE}" || die
	"$(PYTHON)" build_mozc.py build -c "${BUILDTYPE}" ${mytarget} || die
}

src_test() {
	"$(PYTHON)" build_mozc.py runtests -c "${BUILDTYPE}" || die
}

src_install() {
	if use ibus ; then
		exeinto /usr/libexec || die
		newexe "out_linux/${BUILDTYPE}/ibus_mozc" ibus-engine-mozc || die
		insinto /usr/share/ibus/component || die
		doins "out_linux/${BUILDTYPE}/obj/gen/unix/ibus/mozc.xml" || die
	fi

	if use scim ; then
		exeinto "$(pkg-config --variable=moduledir scim)/IMEngine/" || die
		newexe "out_linux/${BUILDTYPE}/lib.target/libscim_mozc.so" mozc.so || die
		exeinto "$(pkg-config --variable=moduledir scim)/SetupUI/" || die
		newexe "out_linux/${BUILDTYPE}/lib.target/libscim_mozc_setup.so" mozc-setup.so || die
	fi

	exeinto "/usr/$(get_libdir)/mozc" || die
	doexe "out_linux/${BUILDTYPE}/mozc_server" || die

	if use qt4 ; then
		exeinto "/usr/$(get_libdir)/mozc" || die
		doexe "out_linux/${BUILDTYPE}/mozc_tool" || die
	fi
}
