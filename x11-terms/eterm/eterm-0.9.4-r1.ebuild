# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/eterm/eterm-0.9.4-r1.ebuild,v 1.6 2008/04/28 17:10:33 dertobi123 Exp $

inherit eutils

MY_P=Eterm-${PV}

if [[ ${PV} == "9999" ]] ; then
	#ECVS_SERVER="cvs.sourceforge.net:/cvsroot/enlightenment"
	ECVS_SERVER="anoncvs.enlightenment.org:/var/cvs/e"
	ECVS_MODULE="eterm/Eterm"
	inherit cvs
fi

DESCRIPTION="A vt102 terminal emulator for X"
HOMEPAGE="http://www.eterm.org/"
if [[ ${PV} == "9999" ]] ; then
	SRC_URI=""
else
	SRC_URI="http://www.eterm.org/download/${MY_P}.tar.gz
		!minimal? ( http://www.eterm.org/download/Eterm-bg-${PV}.tar.gz )
		mirror://sourceforge/eterm/${MY_P}.tar.gz
		!minimal? ( mirror://sourceforge/eterm/Eterm-bg-${PV}.tar.gz )"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE="escreen etwin minimal mmx sse2 unicode"

DEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libICE
	x11-libs/libSM
	x11-proto/xextproto
	x11-proto/xproto
	>=x11-libs/libast-0.6.1
	media-libs/imlib2
	etwin? ( app-misc/twin )
	escreen? ( app-misc/screen )"

if [[ ${PV} == "9999" ]] ; then
	S=${WORKDIR}/${ECVS_MODULE}
else
	S=${WORKDIR}/${MY_P}
fi

pkg_setup() {
	if ! built_with_use media-libs/imlib2 X ; then
		eerror "media-libs/imlib2 was built without X support."
		eerror "Please add emerge it with USE=X."
		die "imlib2 needs USE=X"
	fi
}
src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		cvs_src_unpack
		cd "${S}"
		NOCONFIGURE=yes ./autogen.sh || die "autogen failed"
	else
		unpack ${MY_P}.tar.gz
		cd "${S}"
		use minimal || unpack Eterm-bg-${PV}.tar.gz
		epatch "${FILESDIR}"/eterm-0.9.4-no-default-DISPLAY.patch #216833
	fi
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
