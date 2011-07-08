# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qt-creator/qt-creator-1.3.1-r1.ebuild,v 1.10 2011/07/08 10:08:20 ssuominen Exp $

EAPI="2"
LANGS="de es fr it ja pl ru sl"

inherit qt4-r2 multilib
MY_PN="${PN/-/}"

DESCRIPTION="Lightweight IDE for C++ development centering around Qt"
HOMEPAGE="http://qt.nokia.com/products/developer-tools"
SRC_URI="http://get.qt.nokia.com/${MY_PN}/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux"
IUSE="bineditor bookmarks +cmake cvs debug +designer doc examples fakevim git
kde mercurial perforce qml qtscript rss subversion"

DEPEND=">=x11-libs/qt-assistant-4.6.0:4
	>=x11-libs/qt-gui-4.6.0:4[qt3support]"

RDEPEND="${DEPEND}
	>=x11-libs/qt-sql-4.6.1:4
	>=x11-libs/qt-svg-4.6.1:4
	>=x11-libs/qt-test-4.6.1:4
	>=x11-libs/qt-webkit-4.6.1:4
	!kde? ( || ( >=x11-libs/qt-phonon-4.6.1:4 media-libs/phonon ) )
	kde? ( media-libs/phonon )
	cmake? ( dev-util/cmake )
	cvs? ( dev-vcs/cvs )
	sys-devel/gdb
	examples? ( >=x11-libs/qt-demo-4.6.1:4 )
	git? ( dev-vcs/git )
	mercurial? ( dev-vcs/mercurial )
	qtscript? ( >=x11-libs/qt-script-4.6.1:4 )
	subversion? ( dev-vcs/subversion )"

PLUGINS="bookmarks bineditor cmake cvs designer fakevim git mercurial perforce qml qtscript subversion"

S="${WORKDIR}"/"${P}"-src

src_prepare() {
	qt4-r2_src_prepare

	# bug 263087
	for plugin in ${PLUGINS};do
		if ! use ${plugin};then
			einfo "Disabling ${plugin} support"
			if [[ ${plugin} == "cmake" ]];then
				plugin="cmakeprojectmanager"
			elif [[ ${plugin} == "qtscript" ]];then
				plugin="qtscripteditor"
			fi
			if [[ ${plugin} == "qml" ]]; then
				plugin="qmleditor"
				einfo "Disabling qmlprojectmanager support"
				sed -i "/plugin_qmlprojectmanager/s:^:#:" src/plugins/plugins.pro \
					|| die "Failed to disable qmlprojectmanager plugin"
			fi
			if [[ ${plugin} == "designer" ]]; then
				sed -i "/plugin_qt4projectmanager/s:^:#:" \
					src/plugins/plugins.pro \
					|| die "Failed to disable qt4projectmanager plugin"
			fi
			sed -i "/plugin_${plugin}/s:^:#:" src/plugins/plugins.pro \
				|| die "Failed to disable ${plugin} plugin"
		fi
	done

	if use perforce;then
		ewarn
		ewarn "You have enabled perforce plugin."
		ewarn "In order to use it, you need to manually"
		ewarn "download perforce client from http://www.perforce.com/perforce/downloads/index.html"
		ewarn
		ebeep 5
	fi
	# disable rss news on startup ( bug #302978 )
	if ! use rss; then
		einfo "Disabling RSS welcome news"
		sed -i "/m_rssFetcher->fetch/s:^:\/\/:" \
			src/plugins/welcome/communitywelcomepagewidget.cpp \
			|| die "failed to disable rss"
	fi
}

src_configure() {
	eqmake4 ${MY_PN}.pro IDE_LIBRARY_BASENAME="$(get_libdir)"
}

src_install() {
	emake INSTALL_ROOT="${D%/}${EPREFIX}/usr" install_subtargets || die "emake install failed"
	# fix binary name bug 275859
	mv "${D%/}${EPREFIX}"/usr/bin/${MY_PN}.bin \
		"${D%/}${EPREFIX}"/usr/bin/${MY_PN} || die "failed to rename executable"
	if use doc;then
		emake INSTALL_ROOT="${D%/}${EPREFIX}/usr" install_qch_docs || die "emake install qch_docs failed"
	fi
	make_desktop_entry ${MY_PN} QtCreator qtcreator_logo_48 \
		'Qt;Development;IDE' || die "make_desktop_entry failed"

	# install translations
	for lang in ${LANGS};do
		if ! has ${lang} ${LINGUAS}; then
			rm "${D}"/usr/share/${MY_PN}/translations/${MY_PN}_${lang}.qm \
					|| die "failed to remove ${lang} translation"
		fi
	done
}
