# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xemacs/xemacs-21.4.11.ebuild,v 1.8 2004/04/06 03:44:10 vapier Exp $

inherit eutils

IUSE="gpm postgres ldap xface nas dnd X jpeg tiff png mule motif freewnn canna lucid athena neXt Xaw3d"

# this is just TEMPORARY until we can get to the core of the problem
#SANDBOX_DISABLED="1"

LICENSE="GPL-2"
# handle _rc versions
MY_PV="${PV/_}"
MY_PN="${PN}-${MY_PV}"
MY_PV2="${MY_PV/rc1}"
S="${WORKDIR}/${PN}-${MY_PV2}"
DESCRIPTION="XEmacs is a highly customizable open source text editor and application development system."

SRC_URI="http://ftp.xemacs.org/xemacs-21.4/${PN}-${MY_PV}.tar.gz"

HOMEPAGE="http://www.xemacs.org"

# esound is know to cause problems in XEmacs
#esd? ( media-sound/esound )

RDEPEND="virtual/glibc
	!virtual/xemacs

	>=sys-libs/gdbm-1.8.0
	>=sys-libs/zlib-1.1.4
	>=dev-libs/openssl-0.9.6
	>=media-libs/audiofile-0.2.3

	gpm? ( >=sys-libs/gpm-1.19.6 )

	postgres? ( >=dev-db/postgresql-7.2 )
	ldap? ( net-nds/openldap )

	nas? ( media-libs/nas )

	dnd? ( x11-libs/dnd )

	X? ( virtual/x11 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	athena? ( virtual/x11 )
	Xaw3d? ( x11-libs/Xaw3d )
	neXt? ( x11-libs/neXtaw )
	xface? ( media-libs/compface )
	tiff? ( media-libs/tiff )
	png? ( =media-libs/libpng-1.2* )
	jpeg? ( media-libs/jpeg )

	canna? ( app-i18n/canna )
	freewnn? ( app-i18n/freewnn )"

DEPEND="${RDEPEND}
	>=sys-libs/ncurses-5.2"

PDEPEND="app-xemacs/efs
		 app-xemacs/xemacs-base
		 mule? app-xemacs/mule-base"

PROVIDE="virtual/xemacs virtual/editor"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc ~sparc"

src_unpack() {
	unpack ${PN}-${MY_PV}.tar.gz

	cd ${S}
	epatch ${FILESDIR}/emodules.info-21.4.8-gentoo.patch

	if [ ${ARCH} = "ppc" ] ; then
		epatch ${FILESDIR}/${P}-ppc.diff
	fi

}

src_compile() {
	local myconf=""

	if use X; then

		myconf="--with-widgets=lucid"
		myconf="${myconf} --with-dialogs=lucid"
		myconf="${myconf} --with-scrollbars=lucid"
		myconf="${myconf} --with-menubars=lucid"
		if [ "`use motif`" ] ; then
			myconf="--with-widgets=motif"
			myconf="${myconf} --with-dialogs=motif"
			myconf="${myconf} --with-scrollbars=motif"
			myconf="${myconf} --with-menubars=lucid"
		fi
		if [ "`use athena`" ] ; then
			myconf="--with-widgets=athena"
			if [ "`use Xaw3d`" ] ; then
				myconf="${myconf} --with-athena=xaw3d"
			elif [ "`use neXt`" ] ; then
				myconf="${myconf} --with-athena=next"
			else
				myconf="${myconf} --with-athena=3d"
			fi
			myconf="${myconf} --with-dialogs=athena"
			myconf="${myconf} --with-scrollbars=lucid"
			myconf="${myconf} --with-menubars=lucid"
		fi

		myconf="${myconf}
			--with-gif=no"

		use dnd && myconf="${myconf} --with-dragndrop --with-offix"

		use tiff && myconf="${myconf} --with-tiff" ||
			myconf="${myconf} --without-tiff"
		use png && myconf="${myconf} --with-png" ||
			myconf="${myconf} --without-png"
		use jpeg && myconf="${myconf} --with-jpeg" ||
			myconf="${myconf} --without-jpeg"
		use xface && myconf="${myconf} --with-xface" ||
			myconf="${myconf} --without-xface"

	else
		myconf="${myconf}
			--without-x
			--without-xpm
			--without-dragndrop
			--with-gif=no"
	fi

	use gpm	&& myconf="${myconf} --with-gpm" ||
		myconf="${myconf} --without-gpm"
	use postgres && myconf="${myconf} --with-postgresql" ||
		myconf="${myconf} --without-postgresql"
	use ldap && myconf="${myconf} --with-ldap" ||
		myconf="${myconf} --without-ldap"

	if [ "`use mule`" ] ; then
		myconf="${myconf} --with-mule"
		use motif && myconf="${myconf} --with-xim=motif" ||
			myconf="${myconf} --with-xim=xlib"
	        use canna && myconf="${myconf} --with-canna" ||
	                myconf="${myconf} --without-canna"
		use freewnn && myconf="${myconf} --with-wnn" ||
	                myconf="${myconf} --without-wnn"
	fi

	local soundconf="native"

	use nas	&& soundconf="${soundconf},nas"

	myconf="${myconf} --with-sound=${soundconf}"

	./configure ${myconf} \
		--prefix=/usr \
		--with-pop \
		--with-ncurses \
		--with-msw=no \
		--mail-locking=flock \
		--with-database=gnudbm \
		--with-site-lisp=yes \
		|| die

	# emake dont work on faster boxes it seems
	# azarah (04 Aug 2002)
	make || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 \
		infodir=${D}/usr/share/info \
		install gzip-el || die

	# install base packages
	dodir /usr/lib/xemacs/xemacs-packages/
	dodir /usr/lib/xemacs/site-packages/

	if use mule;
	then
		dodir /usr/lib/xemacs/mule-packages
	fi

	# remove extraneous files
	cd ${D}/usr/share/info
	rm -f dir info.info texinfo* termcap*
	cd ${S}
	dodoc BUGS CHANGES-* COPYING ChangeLog GETTING* INSTALL PROBLEMS README*
	dodoc ${FILESDIR}/README.Gentoo
	rm -f ${D}/usr/share/info/emodules.info~*
}

