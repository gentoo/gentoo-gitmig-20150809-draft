# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/eterm/eterm-0.9.1-r4.ebuild,v 1.5 2002/10/04 06:46:19 vapier Exp $

MY_PN=${PN/et/Et}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A vt102 terminal emulator for X"
SRC_URI="http://www.eterm.org/download/${MY_P}.tar.gz
		 http://www.eterm.org/download/${MY_PN}-bg-${PV}.tar.gz
		 http://www.eterm.org/themes/0.9.1/glass-${MY_PN}-theme.tar.gz"
HOMEPAGE="http://eterm.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11
	>=x11-libs/libast-0.4-r1
	imlib? ( media-libs/imlib2 )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	unpack ${MY_PN}-bg-${PV}.tar.gz
}

src_compile() {
	
	# always disable mmx because binutils 2.11.92+ seems to be broken for this package
	local myconf="--disable-mmx"

	use imlib \
		&& myconf="${myconf} --with-imlib --enable-trans" \
		|| myconf="${myconf} --without-imlib --disable-trans"

    econf \
		--with-x \
		--enable-multi-charset \
		--with-delete=execute \
		${myconf} || die
		
    emake || die

}

src_install () {

    cd ${S}
	dodir /usr/share/terminfo
    make 	\
		DESTDIR=${D}	\
		TIC="tic -o ${D}/usr/share/terminfo"	\
		install || die

    dodoc COPYING ChangeLog README ReleaseNotes
    dodoc bg/README.backgrounds
	cd ${D}/usr/share/Eterm/themes
	unpack glass-Eterm-theme.tar.gz
}
