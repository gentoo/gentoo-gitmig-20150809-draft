# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/fbreader/fbreader-0.12.1.ebuild,v 1.1 2009/12/21 12:06:49 scarabeus Exp $

EAPI=2

inherit confutils

DESCRIPTION="E-Book Reader. Supports many e-book formats."
HOMEPAGE="http://www.fbreader.org/"
SRC_URI="http://www.fbreader.org/${PN}-sources-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="debug gtk +qt4"
DEPEND="dev-libs/expat
	dev-libs/liblinebreak
	net-misc/curl
	dev-libs/fribidi
	app-arch/bzip2
	qt4? ( x11-libs/qt-gui:4 )
	gtk? ( >=x11-libs/gtk+-2.4 )
	"
RDEPEND="${DEPEND}"

pkg_setup() {
	confutils_require_one qt4 gtk
}

src_prepare() {
	#Tidy up the .desktop file
	sed -i "s:^Name=E-book reader:Name=FBReader:" fbreader/desktop/desktop || die "sed failed"
	sed -i "s:^Name\[ru\]=.*$:Name\[ru\]=FBReader:" fbreader/desktop/desktop || die "sed failed"
	sed -i "s:^Icon=FBReader.png:Icon=FBReader:" fbreader/desktop/desktop || die "sed failed"
	sed -i "s:^	LDFLAGS += -s::" makefiles/config.mk || die "sed failed"

	echo "TARGET_ARCH = desktop" > makefiles/target.mk
	echo "LIBDIR = /usr/$(get_libdir)" >> makefiles/target.mk

	if use qt4 ; then
	# qt4
		echo "UI_TYPE = qt4" >> makefiles/target.mk

		sed -i "s:MOC = moc-qt4:MOC = /usr/bin/moc:" makefiles/arch/desktop.mk || die "updating desktop.mk failed"
		sed -i "s:UILIBS = -lQtGui:UILIBS = -L/usr/lib/qt4 -lQtGui:" makefiles/arch/desktop.mk
	elif use gtk ; then
	# gtk
		echo "UI_TYPE = gtk" >> makefiles/target.mk
	fi

	if use debug ; then
		echo "TARGET_STATUS = debug" >> makefiles/target.mk
	else
		echo "TARGET_STATUS = release" >> makefiles/target.mk
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dosym /usr/bin/FBReader /usr/bin/fbreader
}
