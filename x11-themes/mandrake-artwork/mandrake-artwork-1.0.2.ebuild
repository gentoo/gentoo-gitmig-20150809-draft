# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mandrake-artwork/mandrake-artwork-1.0.2.ebuild,v 1.17 2005/10/04 13:37:37 metalgod Exp $

inherit eutils kde-functions

MDK_EXTRAVERSION="1mdk"

DESCRIPTION="Mandrake's Galaxy theme for GTK1, GTK2, Metacity and KDE"
HOMEPAGE="http://www.mandrivalinux.com/"
SRC_URI="mirror://gentoo/galaxy-${PV}-${MDK_EXTRAVERSION}.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="kde"

RDEPEND=">=x11-libs/gtk+-2.0
	 >=media-libs/gdk-pixbuf-0.2.5
	 =x11-libs/gtk+-1.2*
	 kde? ( || ( kde-base/kwin kde-base/kdebase ) )"
DEPEND="${RDEPEND}
	app-arch/rpm2targz"

S=${WORKDIR}/galaxy-${PV}

src_unpack() {
	rpm2targz "${DISTDIR}/${A}" || die
	tar xz --no-same-owner -f galaxy-${PV}-${MDK_EXTRAVERSION}.src.tar.gz || die
	tar xj --no-same-owner -f galaxy-${PV}.tar.bz2 || die
}

src_compile() {
	if use kde ; then
		set-qtdir 3
		set-kdedir 3
		sed -i s:\$\{libdir\}\/kwin.la:${KDEDIR}/lib/kwin.la:g thememdk/mandrake_client/Makefile.in
		econf --with-qt-dir=${QTDIR} || die "econf failed"
	else
		sed -i \
			-e s/KDE_CHECK_FINAL// \
			-e s/AC_PATH_KDE// \
			configure.in || die
		autoconf || die
		sed -i \
			-e s/thememdk// \
			-e s/thememdk// \
			Makefile.am || die
		automake || die
		econf || die
	fi
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS README ChangeLog
}
