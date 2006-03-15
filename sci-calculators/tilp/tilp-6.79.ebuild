# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/tilp/tilp-6.79.ebuild,v 1.1 2006/03/15 04:54:13 ribosome Exp $

inherit eutils

DESCRIPTION="TiLP - A linking program for Texas Instruments' graphing
calculators"
HOMEPAGE="http://tilp.info/"
SRC_URI="mirror://sourceforge/tilp/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="nls"

DEPEND=">=sci-libs/libticables-3.8.0
		>=sci-libs/libticalcs-4.5.4
		>=sci-libs/libtifiles-0.6.1
		app-text/dos2unix
		>=x11-libs/gtk+-2
		>=gnome-base/libglade-2
		nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-makefile.patch
	epatch "${FILESDIR}"/${PV}-makefile-desktop.patch
	epatch "${FILESDIR}"/keepdir.patch
	epatch "${FILESDIR}"/${PV}-Makefile.in.patch
	epatch "${FILESDIR}"/${PV}-Makefile.am.patch
	epatch "${FILESDIR}"/${PV}-registry-Makefile.in.patch
	epatch "${FILESDIR}"/${PV}-registry-Makefile.am.patch
	epatch "${FILESDIR}"/${PV}-plugins-Makefile.in.patch
	epatch "${FILESDIR}"/${PV}-plugins-Makefile.am.patch

	# Install "registry" files in ${D} rather than to the root dir.
	cd "${S}"/registry
	sed -i -e 's:prefix = /usr:prefix = $(D)/usr:' Makefile
	cd "${S}"
}

src_compile() {
	# Note the special option --with-fontpath-prefix below.
	cd ${WORKDIR}/${P}/
	LDFLAGS='-export-dynamic' ./configure \
		$(use_enable nls) \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--with-fontpath-prefix=${D}/usr/share/fonts \
		--enable-exit-homedir || die

	emake || die
}

src_install() {
	# The SHARE_DIR is required since it isn't set properly in a makefile.
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README README.linux RELEASE THANKS TODO
	keepdir /usr/lib/tilp
}
