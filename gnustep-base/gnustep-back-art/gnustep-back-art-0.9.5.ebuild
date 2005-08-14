# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-back-art/gnustep-back-art-0.9.5.ebuild,v 1.6 2005/08/14 10:09:49 hansmi Exp $

inherit gnustep

S=${WORKDIR}/gnustep-back-${PV}

DESCRIPTION="libart_lgpl back-end component for the GNUstep GUI Library."

HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-back-${PV}.tar.gz"
KEYWORDS="~alpha ~amd64 ppc sparc x86"
SLOT="0"
LICENSE="LGPL-2.1"

PROVIDE="virtual/gnustep-back"

IUSE="opengl xim doc"
DEPEND="${GNUSTEP_CORE_DEPEND}
	~gnustep-base/gnustep-make-1.10.0
	~gnustep-base/gnustep-base-1.10.3
	~gnustep-base/gnustep-gui-0.9.5
	virtual/xft
	~media-libs/freetype-2.1.9
	opengl? ( virtual/opengl virtual/glu )
	gnustep-libs/artresources
	>=gnustep-base/mknfonts-0.5
	>=media-libs/libart_lgpl-2.3"
RDEPEND="${DEPEND}
	${DEBUG_DEPEND}
	${DOC_RDEPEND}"

egnustep_install_domain "System"

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/font-make-fix.patch-${PV}
}

src_compile() {
	egnustep_env

	use opengl && myconf="--enable-glx"
	myconf="$myconf `use_enable xim`"
	myconf="$myconf --enable-server=x11"
	myconf="$myconf --enable-graphics=art --with-name=art"
	econf $myconf || die "configure failed"

	egnustep_make
}

src_install() {
	gnustep_src_install
	cd ${S}
	egnustep_env
	mkdir -p ${D}/System/Library/Fonts
	cp -a Fonts/Helvetica.nfont ${D}/${GNUSTEP_SYSTEM_ROOT}/Library/Fonts
}

