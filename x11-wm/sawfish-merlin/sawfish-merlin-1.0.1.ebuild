# Copyright 2001 theLeaf sprl/bvba
# Author Geert Bevin <gbevin@theleaf.be>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish-merlin/sawfish-merlin-1.0.1.ebuild,v 1.2 2002/02/17 16:41:15 gbevin Exp $

A=sawfish-${PV}.tar.gz
S=${WORKDIR}/sawfish-${PV}
DESCRIPTION="Extensions for sawfish which provide pages, iconbox and other nice things."
SRC_URI="http://prdownloads.sourceforge.net/sawmill/"${A}
HOMEPAGE="http://www.merlin.org/sawfish"

DEPEND=">=dev-libs/rep-gtk-0.15-r1
	>=dev-libs/librep-0.14
	>=media-libs/imlib-1.9.10-r1
	esd? ( >=media-sound/esound-0.2.22 )
	readline? ( >=sys-libs/readline-4.1 )
	nls? ( sys-devel/gettext )
	gnome? ( >=media-libs/gdk-pixbuf-0.11.0-r1
			 >=gnome-base/gnome-core-1.4.0.4-r1 )"

RDEPEND=">=dev-libs/rep-gtk-0.15-r1
	>=dev-libs/librep-0.14
	>=x11-libs/gtk+-1.2.10-r4
	>=media-libs/imlib-1.9.10-r1
	>=x11-wm/sawfish-1.0.1
	esd? ( >=media-sound/esound-0.2.22 )
	gnome? ( >=media-libs/gdk-pixbuf-0.11.0-r1
	>=gnome-base/gnome-core-1.4.0.4-r1 )"

src_unpack() {

	unpack ${A}
	cd ${S}/po
	cd ${S}/src
	patch -p1 < ${FILESDIR}/x.c.patch-merlin-1.0.2
}


src_compile() {

  	local myconf
	if [ "`use esd`" ]
	then
		myconf="--with-esd"
	else
		myconf="--without-esd"
	fi
	if [ "`use gnome`" ]
	then
		myconf="${myconf} --with-gnome-prefix=/usr --enable-gnome-widgets --enable-capplet"
	else
		myconf="${myconf} --disable-gnome-widgets --disable-capplet --without-gdk-pixbuf"
	fi
	if [ "`use readline`" ]
	then
		myconf="${myconf} --with-readline"
	else
		myconf="${myconf} --without-readline"
	fi
	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-linguas"
	fi

	./configure --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--libexecdir=/usr/lib \
		--with-audiofile \
		${myconf} || die

	emake || die
	
}

src_install() {
	mkdir -p ${D}/usr/lib/sawfish/${PV}/sawfish-merlin/sawfish/wm/util
	cp src/.libs/x.* ${D}/usr/lib/sawfish/${PV}/sawfish-merlin
	cp src/.libs/x.* ${D}/usr/lib/sawfish/${PV}/sawfish-merlin/sawfish/wm/util
	
	dodir /etc/X11/gdm/Sessions/
	exeinto /etc/X11/gdm/Sessions/
	newexe ${FILESDIR}/gdm_session Sawfish
	
	dodir /etc/skel
	insinto /etc/skel
	cp -a ${FILESDIR}/sawfish ${D}/etc/skel/.sawfish
	find ${D}/etc/skel/.sawfish -name "CVS" -exec rm -rf '{}' ';'
	cp -a ${FILESDIR}/sawfishrc ${D}/etc/skel/.sawfishrc
}



