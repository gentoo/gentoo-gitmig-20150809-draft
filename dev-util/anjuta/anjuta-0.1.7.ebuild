# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="A versatile Integrated Development Environment (IDE) for C and C++."
SRC_URI="http://anjuta.sourceforge.net/packages/anjuta-${PV}.tar.gz"
HOMEPAGE="http://anjuta.sourceforge.net/"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=x11-libs/gtk+-1.2.10-r4
	media-libs/audiofile
	dev-libs/libxml
	app-text/scrollkeeper"
	
RDEPEND="dev-util/glade
	 dev-util/glademm
	 media-gfx/gnome-iconedit
	 app-text/scrollkeeper
	 >=x11-libs/gtk+-1.2.10-r4
	 media-libs/audiofile
	 media-sound/esound
	 sys-apps/bash
	 dev-util/ctags
	 sys-devel/autoconf
	 sys-devel/automake
	 sys-devel/gcc
	 sys-devel/gdb
	 sys-apps/grep
	 >=sys-libs/db-3.2.3"


src_compile() {
        
	local myconf
	use nls || myconf="--disable-nls"

	./configure --host=${CHOST} --prefix=/usr  --mandir=/usr/share/man \
		--infodir=/usr/share/info --with-sysconfdir=/etc \
		$myconf || die
	emake || die
}

src_install () {
	
	make  DESTDIR=${D}  anjutadocdir=/usr/share/doc/${PF} \
		anjuta_docdir=/usr/share/doc/${PF} install || die

}

