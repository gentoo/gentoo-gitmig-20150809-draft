# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtcurve/qtcurve-0.46.4.ebuild,v 1.1 2007/03/05 15:30:12 beandog Exp $

inherit eutils kde-functions

MY_P_GTK2="${P/qtcurve/QtCurve-Gtk2}"
MY_P_KDE="${P/qtcurve/QtCurve-KDE3}"
DESCRIPTION="A set of widget styles for KDE and GTK2 based apps."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="gtk? ( http://home.freeuk.com/cpdrummond/${MY_P_GTK2}.tar.gz )
	kde? ( http://home.freeuk.com/cpdrummond/${MY_P_KDE}.tar.gz )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"
IUSE="gtk kde"
DEPEND="gtk? (
		x11-libs/cairo
		>=x11-libs/gtk+-2.0
	)
	kde? (
		kde-base/kdelibs
		>=x11-libs/qt-3.3
	)"

S="${WORKDIR}"

src_compile() {
	if use kde ; then
		cd ${S}/${MY_P_KDE}
		econf --without-arts || die "econf failed"
		emake || die "emake failed"
	fi
	if use gtk ; then
		cd ${S}/${MY_P_GTK2}
		econf || die "econf failed"
		emake || die "emake failed"
	fi
}

src_install () {
	for pkg in ${MY_P_GTK2} ${MY_P_KDE}
	do
		if [[ -d ${S}/$pkg ]] ; then
			cd ${S}/$pkg
			emake DESTDIR=${D} install || die "emake install failed"
			docinto $pkg
			dodoc ChangeLog README TODO
		fi
	done
}
