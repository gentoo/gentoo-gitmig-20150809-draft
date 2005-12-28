# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cegui/cegui-0.4.0.ebuild,v 1.2 2005/12/28 19:16:34 mr_bones_ Exp $

inherit eutils gnuconfig

DESCRIPTION="Crazy Eddie's GUI System"
HOMEPAGE="http://www.cegui.org.uk/"
SRC_URI="mirror://sourceforge/crayzedsgui/${PN}_mk2-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="opengl devil doc xerces-c"

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
	gnuconfig_update #work around symlink bug #101280
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
		dohtml -r documentation/api_reference/*
		insinto /usr/share/doc/${PF}/Docs
		doins documentation/Falagard_Skining_Docs.pdf
		insinto /usr/share/doc/${PF}/Samples
		doins -r Samples/*
	fi
}
