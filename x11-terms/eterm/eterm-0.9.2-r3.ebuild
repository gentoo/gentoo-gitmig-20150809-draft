# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/eterm/eterm-0.9.2-r3.ebuild,v 1.6 2003/03/20 12:54:14 seemant Exp $

MY_PN=${PN/et/Et}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A vt102 terminal emulator for X"
SRC_URI="http://www.eterm.org/download/${MY_P}.tar.gz
	 http://www.eterm.org/download/${MY_PN}-bg-${PV}.tar.gz"
HOMEPAGE="http://www.eterm.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha ~sparc"
IUSE=""

DEPEND="virtual/x11
	>=x11-libs/libast-0.5
	media-libs/imlib2
	>=sys-devel/binutils-2.13*"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	unpack ${MY_PN}-bg-${PV}.tar.gz
}

src_compile() {
	# always disable mmx because binutils 2.11.92+ seems to be broken for this package
	local myconf="--disable-mmx --with-gnu-ld"

	econf \
		--with-imlib \
		--enable-trans \
		--with-x \
		--enable-multi-charset \
		--with-delete=execute \
		--with-backspace=auto \
		--enable-escreen \
		--enable-etwin \
		${myconf}

	emake || die
}

src_install() {
	dodir /usr/share/terminfo
	make \
		DESTDIR=${D} \
		TIC="tic -o ${D}/usr/share/terminfo" \
		install || die

	dodoc COPYING ChangeLog README ReleaseNotes
	dodoc bg/README.backgrounds
}
