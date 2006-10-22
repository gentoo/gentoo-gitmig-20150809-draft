# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xlockmore/xlockmore-5.21-r1.ebuild,v 1.8 2006/10/22 09:41:01 corsair Exp $

inherit gnuconfig eutils pam flag-o-matic

IUSE="nas esd motif opengl truetype gtk pam xlockrc unicode"

DESCRIPTION="Just another screensaver application for X"
SRC_URI="http://ftp.tux.org/pub/tux/bagleyd/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.tux.org/~bagleyd/xlockmore.html"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 hppa ppc ppc64 sparc x86"

RDEPEND="|| ( (
		media-libs/mesa
		x11-libs/libX11
		x11-libs/libXmu
		x11-libs/libXext
		x11-libs/libXdmcp
		x11-libs/libXt
		x11-libs/libXpm )
	virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xextproto
		x11-proto/xproto
		x11-proto/xineramaproto )
	virtual/x11 )
	media-libs/freetype
	opengl? ( virtual/opengl )
	pam? ( virtual/pam )
	nas? ( media-libs/nas )
	esd? ( media-sound/esound )
	motif? ( x11-libs/openmotif )
	gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {

	local myconf

	use xlockrc && myconf="${myconf} --enable-xlockrc"
	use opengl || myconf="${myconf} --without-opengl --without-gltt --without-mesa"
	use unicode && myconf="${myconf} --enable-use-mb"

	econf \
		--sharedstatedir=${D}/usr/share/xlockmore \
		--enable-vtlock \
		--without-ftgl \
		$(use_enable pam) \
		$(use_with truetype ttf) \
		$(use_with gtk) \
		$(use_with motif) \
		$(use_with esd esound) \
		$(use_with nas) \
		${myconf} \
		|| die "econf failed"

	# fixes suid-with-lazy-bindings problem
	append-flags $(bindnow-flags)

	emake || die "Make failed"

}

src_install() {
	einstall \
		xapploaddir=${D}/etc/X11/app-defaults \
		mandir=${D}/usr/share/man/man1 \
		|| die "einstall failed"

	#Install pam.d file and unset setuid root
	pamd_mimic_system xlock auth
	use pam && chmod 755 ${D}/usr/bin/xlock

	insinto /usr/share/xlockmore/sounds
	doins sounds/*

	dodoc docs/* README
	dohtml docs/*.html
	rm ${D}/usr/share/doc/${PF}/*.html.gz
}
