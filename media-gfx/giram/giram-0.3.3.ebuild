# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/giram/giram-0.3.3.ebuild,v 1.3 2003/09/06 23:56:38 msterret Exp $

DESCRIPTION="Giram (Giram is really a modeller). A 3d modeller for POV-ray"
HOMEPAGE="http://www.giram.org"
SRC_URI="http://www.giram.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0
	media-gfx/povray
	"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	"

S=${WORKDIR}/${P}

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

	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS ANNOUNCE CONTRIBUTORS ChangeLog HACKING IDEAS NEWS README TODO
}
