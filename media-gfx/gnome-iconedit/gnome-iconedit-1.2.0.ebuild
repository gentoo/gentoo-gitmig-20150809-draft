# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="Edits icons, what more can you say?"
SRC_URI="http://210.77.60.218/ftp/ftp.debian.org/pool/main/g/gnome-iconedit/gnome-iconedit_${PV}.orig.tar.gz"
HOMEPAGE="www.advogato.org/proj/GNOME-Iconedit/"

DEPEND="gnome-base/gnome-libs
	x11-libs/gtk+
	media-libs/gdk-pixbuf
	media-libs/libpng
	gnome-base/gnome-print"
# Bonobo support is broken
#	bonobo? ( gnome-base/bonobo )"



src_unpack() {

	unpack ${A}

	# Fix some compile / #include errors
	cd ${S}
	patch -p1 <${FILESDIR}/gnome-iconedit.diff || die

}

src_compile() {
        	
	local myconf
	use nls || myconf="--disable-nls"

	# Needed by .diff
	automake
	autoconf

	./configure --host=${CHOST} --prefix=/opt/gnome  --mandir=/usr/share/man \
		--infodir=/usr/share/info --with-sysconfdir=/etc/opt/gnome \
		$myconf || die

	emake || die
}

src_install () {
	
	make DESTDIR=${D} install || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

}

