# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nano/nano-1.2.0.ebuild,v 1.6 2003/04/16 00:43:41 gmsoft Exp $

MY_P="${PN}-${PV/_}"
DESCRIPTION="clone of Pico with more functions in a smaller size"
SRC_URI="http://www.nano-editor.org/dist/v1.2/${MY_P}.tar.gz"
HOMEPAGE="http://www.nano-editor.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha ~mips hppa arm"
IUSE="nls build slang spell"

S=${WORKDIR}/${MY_P}

DEPEND=">=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )"

PROVIDE="virtual/editor"

src_compile() {
	use build && myconf="${myconf} --disable-wrapping-as-root"

	econf \
		--bindir=/bin \
		--enable-color \
		--enable-multibuffer \
		--enable-nanorc \
		`use_enable spell` \
		`use_enable nls` \
		${myconf} \
		|| die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	use build \
		&& rm -rf ${D}/usr/share \
		|| dodoc ChangeLog README nanorc.sample AUTHORS BUGS NEWS TODO \
		&& dohtml *.html

	dodir /usr/bin
	dosym /bin/nano /usr/bin/nano
}
