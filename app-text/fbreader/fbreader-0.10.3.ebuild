# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/fbreader/fbreader-0.10.3.ebuild,v 1.1 2009/02/06 19:09:22 alexxy Exp $

EAPI=2

DESCRIPTION="E-Book Reader. Supports many e-book formats."
HOMEPAGE="http://www.fbreader.org/"
SRC_URI="http://www.fbreader.org/${PN}-sources-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="qt3 qt4 gtk debug"
DEPEND="dev-libs/expat
	>=dev-libs/liblinebreak-1.0
	net-misc/curl
	dev-libs/fribidi
	app-arch/bzip2
	qt4? ( || ( x11-libs/qt-gui:4 =x11-libs/qt-4.3* ) )
	qt3? ( =x11-libs/qt-3* )
	gtk? ( >=x11-libs/gtk+-2.4 )
	"
RDEPEND="${DEPEND}"

pkg_setup() {
	local toolkitsnum toolkitstypes="qt3 qt4 gtk" toolkitstype
	declare -i toolkitsnum=0
	for toolkitstype in ${toolkitstypes}; do
		useq ${toolkitstype} && let toolkitsnum++
	done
	if [ ${toolkitsnum} -gt 1 ]; then
		eerror
		eerror "You can't use more than one of toolkits."
		eerror "Select exactly one toolkits type out of these: ${toolkitstypes}"
		eerror
		die "Multiple toolkits types selected."
	elif [ ${toolkitsnum} -lt 1 ]; then
		eerror
		eerror "Select exactly one toolkits type out of these: ${toolkitstypes}"
		eerror
		die "No toolkits type selected."
	fi
}

src_prepare() {
	#Tidy up the .desktop file
	sed -i "s:^Name=E-book reader:Name=FBReader:" fbreader/desktop/desktop || die "sed failed"
	sed -i "s:^Name\[ru\]=.*$:Name\[ru\]=FBReader:" fbreader/desktop/desktop || die "sed failed"

	echo "TARGET_ARCH = desktop" > makefiles/target.mk

	if use qt4 ; then
	# qt4
		echo "UI_TYPE = qt4" >> makefiles/target.mk

		sed -i "s:MOC = moc-qt4:MOC = /usr/bin/moc:" makefiles/arch/desktop.mk || die "updating desktop.mk failed"
		sed -i "s:UILIBS = -lQtGui:UILIBS = -L/usr/lib/qt4 -lQtGui:" makefiles/arch/desktop.mk
	fi

	if use qt3 ; then
	# qt3
		echo "UI_TYPE = qt" >> makefiles/target.mk

		sed -i "s:MOC = moc-qt3:MOC = ${QTDIR}/bin/moc:" makefiles/arch/desktop.mk || die "updating desktop.mk failed"
		sed -i "s:QTINCLUDE = -I /usr/include/qt3:QTINCLUDE = -I ${QTDIR}/include:" makefiles/arch/desktop.mk || die "updating desktop.mk failed"
		sed -i "s:UILIBS = -lqt-mt:UILIBS = -L${QTDIR}/lib -lqt-mt:" makefiles/arch/desktop.mk

	fi

	if use gtk ; then
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
