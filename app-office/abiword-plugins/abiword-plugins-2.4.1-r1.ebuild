# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword-plugins/abiword-plugins-2.4.1-r1.ebuild,v 1.2 2005/10/31 01:08:02 weeve Exp $

DESCRIPTION="Set of plugins for abiword"
HOMEPAGE="http://www.abisource.com/"
SRC_URI="http://www.abisource.com/downloads/abiword/${PV}/abiword-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="gnome grammar jpeg math svg libgda thesaurus wordperfect"
S=${WORKDIR}/abiword-${PV}/${PN}

RDEPEND="=app-office/abiword-${PV}
		>=app-text/aiksaurus-1.2
		virtual/xft
		>=media-libs/fontconfig-2.1
		>=dev-libs/glib-2
		>=x11-libs/gtk+-2
		>=gnome-base/libglade-2
		grammar? ( >=dev-libs/link-grammar-4.1.3 )
		math? ( >=x11-libs/gtkmathview-0.7.5 )
		thesaurus? ( >=app-text/aiksaurus-1.2 )
		wordperfect? ( >=app-text/libwpd-0.8.0 )
		gnome? ( >=x11-libs/goffice-0.1.0 )
		libgda? ( >=gnome-extra/libgda-1.2 )
		jpeg?  ( >=media-libs/jpeg-6b-r2 )
		svg? ( >=gnome-base/librsvg-2.9.5 )"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_compile() {

	econf \
		--enable-all \
		--with-abiword=${WORKDIR}/abiword-${PV}/abi \
		`use_with grammar abigrammar` \
		`use_with math abimathview` \
		`use_with thesaurus aiksaurus` \
		`use_with wordperfect` \
		`use_with gnome abigochart` \
		`use_with svg librsvg` \
		`use_with jpeg` \
		`use_with libgda gda` \
		--without-psion \
		--without-libwmf \
		--without-ImageMagick || die "configure failed"

		emake || die "make failed"
}

src_install() {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README
}
