# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/eterm/eterm-0.9.2-r5.ebuild,v 1.4 2004/01/02 21:49:09 aliz Exp $

inherit eutils

MY_PN=${PN/et/Et}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A vt102 terminal emulator for X"
HOMEPAGE="http://www.eterm.org/"
SRC_URI="mirror://sourceforge/eterm/${MY_P}.tar.gz http://www.eterm.org/download/${MY_P}.tar.gz
	 mirror://sourceforge/eterm/${MY_PN}-bg-${PV}.tar.gz http://www.eterm.org/download/${MY_PN}-bg-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa ~amd64"
IUSE="mmx etwin"

DEPEND="virtual/x11
	>=x11-libs/libast-0.5
	media-libs/imlib2
	>=sys-devel/binutils-2.13*
	etwin? ( app-misc/twin )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	unpack ${MY_PN}-bg-${PV}.tar.gz
	epatch ${FILESDIR}/${PV}-ansi16.patch
	sed -i 's:Tw/Tw_1\.h:Tw/Tw1.h:' src/libscream.c
}

src_compile() {
	local myconf
	myconf="--with-imlib \
		--enable-trans \
		--with-x \
		--enable-multi-charset \
		--with-delete=execute \
		--with-backspace=auto \
		--enable-escreen \
		`use_enable etwin`"

	if [ "${ARCH}" == "x86" ]; then
		myconf="$myconf `use_enable mmx`"
	else
		myconf="$myconf --disable-mmx"
	fi

	econf $myconf || die "conf failed"
	emake || die "make failed"
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
