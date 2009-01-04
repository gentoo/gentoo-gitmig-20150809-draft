# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/minichinput/minichinput-0.1.9.ebuild,v 1.9 2009/01/04 22:36:51 ulm Exp $

inherit eutils

MY_P=${P/minichinput/miniChinput}

DESCRIPTION="Chinese Input Method. Replaces Chinput as a smaller package without the dependency on unicon."
HOMEPAGE="http://www-scf.usc.edu/~bozhang/miniChinput/ http://sourceforge.net/projects/minichinput/"
SRC_URI="mirror://sourceforge/minichinput/${MY_P}.tar.gz
	mirror://sourceforge/minichinput/${MY_P}-rxvt.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/libXft
	media-libs/fontconfig
	>=media-libs/imlib-1.9.13
	!app-i18n/chinput"
RDEPEND="${DEPEND}
	media-fonts/font-sony-misc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	epatch ${DISTDIR}/${MY_P}-rxvt.patch
	epatch ${FILESDIR}/${P}-xorg-x11.patch
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_compile() {
	econf \
		--x-includes=/usr/include \
		--x-libraries=/usr/lib || die "configure failed"
	emake || die "make failed"
	emake data || die "make data failed"
}

src_install() {
	make prefix=${D}/usr \
		packagename=${P} \
		mandir=share/man/man1 \
		install|| die "install failed"
	make prefix=${D}/usr data-install || die "install data failed"
}
