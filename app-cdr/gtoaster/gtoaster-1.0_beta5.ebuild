# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Nästén <pekdon@gmx.net>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gtoaster/gtoaster-1.0_beta5.ebuild,v 1.2 2002/02/12 01:23:19 verwilst Exp $

# Fix so that updating can only be done by 'cp old.ebuild new.ebuild'
MY_P="`echo ${P} |sed -e 's:-::' -e 's:_b:B:'`"
S=${WORKDIR}/gtoaster
DESCRIPTION="GTK+ Frontend for cdrecord"
SRC_URI="http://gnometoaster.rulez.org/archive/${MY_P}.tgz"
HOMEPAGE="http://gnometoaster.rulez.org/"
SLOT="0"
DEPEND=">=x11-libs/gtk+-1.2
	gnome? ( >=gnome-base/gnome-core-1.2.2.1 )
	esd? ( >=media-sound/esound-0.2.22 )"

RDEPEND=">=app-cdr/cdrtools-1.11
	 >=media-sound/sox-12
	 >=media-sound/mpg123-0.59
	 >=media-sound/mp3info-0.8.4
	 ogg? ( >=media-sound/vorbis-tools-1.0_rc2 )
	 ogg? ( >=media-sound/oggtst-0.0 )"


src_compile() {

	local myconf
	use nls		|| myconf="$myconf --disable-nls"
	use gnome	&& myconf="$myconf --with-gnome --with-orbit"
	use gnome	|| myconf="$myconf --without-gnome --without-orbit"
	use esd		&& myconf="$myconf --with-esd"
	use esd		|| myconf="$myconf --without-esd"
	use oss		&& myconf="$myconf --with-oss"
	use oss		|| myconf="$myconf --without-oss"

	
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --infodir=/usr/share/info				\
		    --mandir=/usr/share/man				\
	            $myconf || die

	emake || die
}

src_install() {

	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     infodir=${D}/usr/share/info				\
	     mandir=${D}/usr/share/man					\
	     install || die

	dodoc ABOUT-NLS AUTHORS ChangeLog* COPYING INSTALL NEWS README TODO
	docinto user-guide
	dodoc Documentation/*.txt
	dodoc Documentation/*.html
	dodoc Documentation/*.png

        # Install icon and .desktop for menu entry
        if [ "`use gnome`" ] ; then
                insinto /usr/share/pixmaps
                doins ${S}/icons/gtoaster.png
                insinto /usr/share/gnome/apps/Applications
                doins ${FILESDIR}/gtoaster.desktop
        fi
}


