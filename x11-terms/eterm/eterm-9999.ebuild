# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/eterm/eterm-9999.ebuild,v 1.9 2007/06/24 18:22:41 peper Exp $

#ECVS_SERVER="cvs.sourceforge.net:/cvsroot/enlightenment"
ECVS_SERVER="anoncvs.enlightenment.org:/var/cvs/e"
ECVS_MODULE="eterm/Eterm"
inherit eutils cvs

MY_P=Eterm-${PV}
DESCRIPTION="A vt102 terminal emulator for X"
HOMEPAGE="http://www.eterm.org/"
SRC_URI=""
#http://www.eterm.org/download/${MY_P}.tar.gz
#	http://www.eterm.org/download/Eterm-bg-${PV}.tar.gz
#	mirror://sourceforge/eterm/${MY_P}.tar.gz
#	mirror://sourceforge/eterm/Eterm-bg-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="escreen etwin minimal mmx sse2 unicode"

DEPEND="|| ( ( x11-libs/libX11 x11-libs/libXmu x11-libs/libXt x11-libs/libICE x11-libs/libSM x11-proto/xextproto x11-proto/xproto ) virtual/x11 )
	>=x11-libs/libast-0.6.1
	media-libs/imlib2
	etwin? ( app-misc/twin )
	escreen? ( app-misc/screen )"

S=${WORKDIR}/${ECVS_MODULE}

src_unpack() {
	cvs_src_unpack
	cd "${S}"
	NOCONFIGURE=yes ./autogen.sh || die "autogen failed"
}

src_compile() {
	export TIC="true"
	econf \
		$(use_enable escreen) \
		$(use_enable etwin) \
		--with-imlib \
		--enable-trans \
		$(use_enable mmx) \
		$(use_enable sse2) \
		$(use_enable unicode multi-charset) \
		--with-delete=execute \
		--with-backspace=auto \
		|| die "conf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog README ReleaseNotes
	use escreen && dodoc doc/README.Escreen
	dodoc bg/README.backgrounds
}
