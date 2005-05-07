# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/eterm/eterm-9999.ebuild,v 1.2 2005/05/07 23:17:15 vapier Exp $

ECVS_MODULE="eterm/Eterm"
ECVS_SERVER="cvs.sourceforge.net:/cvsroot/enlightenment"
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
KEYWORDS="-*"
IUSE="mmx etwin escreen"

DEPEND="virtual/x11
	>=x11-libs/libast-0.6.1
	media-libs/imlib2
	etwin? ( app-misc/twin )
	escreen? ( app-misc/screen )"

S=${WORKDIR}/${ECVS_MODULE}

src_unpack() {
	cvs_src_unpack
	cd "${S}"
	# autogen.sh is broken so do this ourselves
	#./autogen.sh || die "autogen failed"
	aclocal -I . && \
	autoheader && \
	libtoolize -c -f && \
	autoconf && \
	automake -a -c || die "autotools failed"
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
		--with-delete=execute \
		--with-backspace=auto \
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
