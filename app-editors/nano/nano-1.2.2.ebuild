# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nano/nano-1.2.2.ebuild,v 1.4 2003/08/20 07:48:00 coronalvr Exp $

inherit eutils

MY_P=${PN}-${PV/_}
DESCRIPTION="GNU GPL'd Pico clone with more functionality"
HOMEPAGE="http://www.nano-editor.org/"
SRC_URI="http://www.nano-editor.org/dist/v1.2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"
IUSE="nls build spell justify debug" # slang"

DEPEND=">=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )"
#	slang? ( sys-libs/slang )" see bug #26897
PROVIDE="virtual/editor"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-tabconvert.patch
}

src_compile() {
	use build && myconf="${myconf} --disable-wrapping-as-root"

	econf \
		--bindir=/bin \
		--enable-color \
		--enable-multibuffer \
		--enable-nanorc \
		`use_enable justify` \
		`use_enable spell` \
		`use_enable debug` \
		`use_enable nls` \
#		`use_with slang` \
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
	dosym ../../bin/nano /usr/bin/nano
}
