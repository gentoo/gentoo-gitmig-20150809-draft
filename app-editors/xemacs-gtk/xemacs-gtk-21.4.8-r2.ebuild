# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xemacs-gtk/xemacs-gtk-21.4.8-r2.ebuild,v 1.13 2004/01/22 22:07:46 mr_bones_ Exp $

IUSE="gpm postgres xface tiff gtk jpeg mule nas esd X png gnome"

# this is just TEMPORARY until we can get to the core of the problem
SANDBOX_DISABLED="1"


REAL_P=${P//-gtk/}
S="${WORKDIR}/${REAL_P}"

DESCRIPTION="highly customizable text editor and application development system"

EFS=1.29
BASE=1.63
MULE=1.40

SRC_URI="http://ftp.xemacs.org/xemacs-21.4/${REAL_P}.tar.gz
	http://ftp.xemacs.org/pub/packages/efs-${EFS}-pkg.tar.gz
	http://ftp.xemacs.org/pub/packages/xemacs-base-${BASE}-pkg.tar.gz
	http://ftp.xemacs.org/packages/mule-base-${MULE}-pkg.tar.gz"

HOMEPAGE="http://www.xemacs.org"

RDEPEND="virtual/glibc
	!virtual/xemacs

	>=sys-libs/gdbm-1.8.0
	>=sys-libs/zlib-1.1.4
	>=dev-libs/openssl-0.9.6
	>=media-libs/audiofile-0.2.3

	xface? ( media-libs/compface )
	gpm? ( >=sys-libs/gpm-1.19.6 )
	postgres? ( >=dev-db/postgresql-7.2 )

	nas? ( media-libs/nas )
	esd? ( media-sound/esound )

	gtk? ( =x11-libs/gtk+-1.2* )
	gnome? ( =gnome-base/gnome-libs-1.4* )

	tiff? ( media-libs/tiff )
	png? ( =media-libs/libpng-1.2* )
	jpeg? ( media-libs/jpeg )

	X? ( virtual/x11 )"

DEPEND="${RDEPEND}
	>=sys-libs/ncurses-5.2"

PROVIDE="virtual/xemacs"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_unpack() {
	cd ${WORKDIR}
	unpack ${REAL_P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/emodules.info-21.4.8-gentoo.patch
}

src_compile() {
	local myconf=""

	if use X;
	then
		myconf="${myconf}
			--with-x
			--with-gtk
			--with-xpm
			--with-dragndrop
			--with-gif=no"

		use gnome && myconf="${myconf} --with-gnome" ||
			myconf="${myconf} --without-gnome"
		use tiff && myconf="${myconf} --with-tiff" ||
			myconf="${myconf} --without-tiff"
		use png && mconf="${myconf} --with-png" ||
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
	use mule && myconf="${myconf} --with-mule" ||
		myconf="${myconf} --without-mule"

	local soundconf="native"

	use nas	&& soundconf="${soundconf},nas"
	use esd	&& soundconf="${soundconf},esd"

	myconf="${myconf} --with-sound=${soundconf}"

	./configure ${myconf} \
		--prefix=/usr \
		--with-database=gnudbm \
		--with-pop \
		--with-ncurses \
		--with-site-lisp=yes \
		--package-path=/usr/lib/xemacs/xemacs-packages/ \
		--with-msw=no \
		|| die

	emake || die
}

src_install() {
	make prefix="${D}/usr" \
		mandir="${D}/usr/share/man/man1" \
		infodir="${D}/usr/share/info" \
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
}
