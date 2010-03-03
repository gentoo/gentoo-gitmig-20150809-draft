# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-assistant/qt-assistant-4.6.2.ebuild,v 1.3 2010/03/03 12:09:37 fauli Exp $

EAPI="2"
inherit qt4-build

DESCRIPTION="The assistant help module for the Qt toolkit"
SLOT="4"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 -sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="~x11-libs/qt-gui-${PV}[aqua=]
	~x11-libs/qt-sql-${PV}[aqua=,sqlite]
	~x11-libs/qt-webkit-${PV}[aqua=]"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.6.1-tools.patch" )

# Pixeltool isn't really assistant related, but it relies on
# the assistant libraries. doc/qch/
QT4_TARGET_DIRECTORIES="
tools/assistant
tools/pixeltool
tools/qdoc3"
QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
tools/
demos/
examples/
src/
include/
doc/"
src_configure() {
	myconf="${myconf} -no-xkb -no-fontconfig -no-xrender -no-xrandr
		-no-xfixes -no-xcursor -no-xinerama -no-xshape -no-sm -no-opengl
		-no-nas-sound -no-dbus -iconv -no-cups -no-nis -no-gif -no-libpng
		-no-libmng -no-libjpeg -no-openssl -system-zlib -no-phonon
		-no-xmlpatterns -no-freetype -no-libtiff -no-accessibility
		-no-fontconfig -no-glib -no-multimedia -no-qt3support -no-svg"
	qt4-build_src_configure
}

src_compile() {
	# help libQtHelp find freshly built libQtCLucene (bug #289811)
	export LD_LIBRARY_PATH="${S}/lib"
	export DYLD_LIBRARY_PATH="${S}/lib:${S}/lib/QtHelp.framework"
	qt4-build_src_compile
	# ugly hack to build docs
	cd "${S}"
	qmake "LIBS+=-L${QTLIBDIR}" "CONFIG+=nostrip" projects.pro || die "qmake projects faied"
	emake qch_docs || die "emake docs failed"
}

src_install() {
	qt4-build_src_install
	# install documentation
	# note that emake install_qchdocs fails for undefined reason so we use a
	# workaround
	cd "${S}"
	insinto ${QTDOCDIR#${EPREFIX}}
	doins -r "${S}"/doc/qch || die "doins qch documentation failed"
	dobin "${S}"/bin/qdoc3 || die "Installing qdoc3 failed"
	#emake INSTALL_ROOT="${D}" install_qchdocs || die "emake install_qchdocs	failed"
	# install correct assistant icon, bug 241208
	dodir /usr/share/pixmaps/ || die "dodir failed"
	insinto /usr/share/pixmaps/ || die "insinto failed"
	doins tools/assistant/tools/assistant/images/assistant.png \
		|| die "doins failed"
	# Note: absolute image path required here!
	make_desktop_entry /usr/bin/assistant Assistant \
		/usr/share/pixmaps/assistant.png 'Qt;Development;GUIDesigner' \
			|| die "make_desktop_entry failed"
}
