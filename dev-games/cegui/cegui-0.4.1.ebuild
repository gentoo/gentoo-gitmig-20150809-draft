# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cegui/cegui-0.4.1.ebuild,v 1.3 2006/02/26 04:33:26 vapier Exp $

inherit eutils

DESCRIPTION="Crazy Eddie's GUI System"
HOMEPAGE="http://www.cegui.org.uk/"
SRC_URI="mirror://sourceforge/crayzedsgui/${PN}_mk2-source-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="devil doc examples opengl xerces-c"

RDEPEND="=media-libs/freetype-2*
	xerces-c? ( >=dev-libs/xerces-c-2.6.0 )
	opengl? ( virtual/opengl )
	devil? ( >=media-libs/devil-1.5 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15.0
	doc? ( >=app-doc/doxygen-1.3.8 )"

S=${WORKDIR}/cegui_mk2

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use examples ; then
		cp -r Samples Samples.clean
		find Samples.clean '(' -name 'Makefile*' -o -name CVS ')' -print0 | xargs -0 rm -rf
	fi
}

src_compile() {
	econf \
		$(use_enable opengl opengl-renderer) \
		$(use_with devil) \
		$(use_with xerces-c) \
		--without-ogre-renderer \
		|| die
	emake || die "emake failed"
	use doc && doxygen
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README TODO ReadMe.html
	if use doc ; then
		dohtml -r documentation/api_reference
		dodoc documentation/*.pdf
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}/Samples
		doins -r Samples.clean/*
	fi
}
