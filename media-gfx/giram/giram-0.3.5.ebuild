# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/giram/giram-0.3.5.ebuild,v 1.1 2005/08/13 16:04:14 vanquirius Exp $

inherit eutils

DESCRIPTION="Giram (Giram is really a modeller). A 3d modeller for POV-ray"
HOMEPAGE="http://www.giram.org"
SRC_URI="http://www.giram.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0
	media-gfx/povray"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-fbsd.patch
	cd ${S}/povfront
	sed -i -e "s:strlen (g_config_file_to_parse) == 0:g_config_file_to_parse == NULL:" povfront.c
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--libexecdir=/usr/lib \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-tutorial-path=/usr/share/doc/${PF} \
		--enable-bishop-s3d --enable-vik-specials || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ANNOUNCE CONTRIBUTORS ChangeLog HACKING IDEAS NEWS README TODO
}
