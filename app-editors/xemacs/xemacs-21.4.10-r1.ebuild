# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xemacs/xemacs-21.4.10-r1.ebuild,v 1.8 2004/01/05 23:35:09 robbat2 Exp $

IUSE="gpm postgres xface nas dnd X jpeg tiff png mule motif canna freewnn lucid athena neXt Xaw3d"

# this is just TEMPORARY until we can get to the core of the problem
SANDBOX_DISABLED="1"

LICENSE="GPL-2"

S="${WORKDIR}/${P}"
DESCRIPTION="XEmacs is a highly customizable open source text editor and application development system."
EFS=1.29
BASE=1.71
MULE=1.42

SRC_URI="http://ftp.xemacs.org/xemacs-21.4/${P}.tar.gz
	http://ftp.xemacs.org/packages/efs-${EFS}-pkg.tar.gz
	http://ftp.xemacs.org/packages/xemacs-base-${BASE}-pkg.tar.gz
	mule? ( http://ftp.xemacs.org/packages/mule-base-${MULE}-pkg.tar.gz )"

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

PROVIDE="virtual/xemacs virtual/editor"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc sparc"


src_unpack() {
	unpack ${P}.tar.gz

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
			myconf="${myconf} --with-scrollbars=athena"
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
		--pdump \
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
	cd ${D}/usr/lib/xemacs/xemacs-packages/
	unpack efs-${EFS}-pkg.tar.gz
	unpack xemacs-base-${BASE}-pkg.tar.gz
	# (optionally) install mule base package
	if use mule;
	then
		dodir /usr/lib/xemacs/mule-packages
		cd ${D}/usr/lib/xemacs/mule-packages/
		unpack mule-base-${MULE}-pkg.tar.gz
	fi

	# remove extraneous files
	cd ${D}/usr/share/info
	rm -f dir info.info texinfo* termcap*
	cd ${S}
	dodoc BUGS CHANGES-* COPYING ChangeLog GETTING* INSTALL PROBLEMS README*
	dodoc ${FILESDIR}/README.Gentoo
	rm -f ${D}/usr/share/info/emodules.info~*
}

