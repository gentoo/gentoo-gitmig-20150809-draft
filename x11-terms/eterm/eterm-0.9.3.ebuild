# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/eterm/eterm-0.9.3.ebuild,v 1.1 2004/12/28 23:10:48 vapier Exp $

inherit eutils

MY_P=Eterm-${PV}
DESCRIPTION="A vt102 terminal emulator for X"
HOMEPAGE="http://www.eterm.org/"
SRC_URI="http://www.eterm.org/download/${MY_P}.tar.gz
	http://www.eterm.org/download/Eterm-bg-${PV}.tar.gz
	mirror://sourceforge/eterm/${MY_P}.tar.gz
	mirror://sourceforge/eterm/Eterm-bg-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="mmx etwin escreen"

RDEPEND="virtual/x11
	>=x11-libs/libast-0.6.1
	media-libs/imlib2
	etwin? ( app-misc/twin )
	escreen? ( app-misc/screen )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	unpack Eterm-bg-${PV}.tar.gz
	sed -i 's:Tw/Tw_1\.h:Tw/Tw1.h:' src/libscream.c || die
}

src_compile() {
	local mymmx
	use x86 \
		&& mymmx="$(use_enable mmx)" \
		|| mymmx="--disable-mmx"
	econf \
		$(use_enable escreen) \
		$(use_enable etwin) \
		--with-imlib \
		--enable-trans \
		${mymmx} \
		--enable-multi-charset \
		|| die "conf failed"
	emake || die "make failed"
}

src_install() {
	make \
		TIC="tic -o ${D}/usr/share/terminfo" \
		DESTDIR="${D}" \
		install || die "install failed"
	dodoc ChangeLog README ReleaseNotes
	use escreen && dodoc doc/README.Escreen
	dodoc bg/README.backgrounds
}
