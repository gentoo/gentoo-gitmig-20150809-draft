# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xemacs/xemacs-21.4.9.ebuild,v 1.12 2004/01/05 23:35:09 robbat2 Exp $

IUSE="gpm esd postgres xface nas X jpeg tiff png mule"

# this is just TEMPORARY until we can get to the core of the problem
SANDBOX_DISABLED="1"

LICENSE="GPL-2"

S="${WORKDIR}/${P}"
DESCRIPTION="XEmacs is a highly customizable open source text editor and application development system."
EFS=1.29
BASE=1.68
MULE=1.42

SRC_URI="http://ftp.xemacs.org/xemacs-21.4/${P}.tar.gz
	http://ftp.xemacs.org/packages/efs-${EFS}-pkg.tar.gz
	http://ftp.xemacs.org/packages/xemacs-base-${BASE}-pkg.tar.gz
	mule? ( http://ftp.xemacs.org/packages/mule-base-${MULE}-pkg.tar.gz )"

HOMEPAGE="http://www.xemacs.org"


RDEPEND="virtual/glibc
	!virtual/xemacs

	>=sys-libs/gdbm-1.8.0
	>=sys-libs/zlib-1.1.4
	>=dev-libs/openssl-0.9.6
	>=media-libs/audiofile-0.2.3

	gpm? ( >=sys-libs/gpm-1.19.6 )
	postgres? ( >=dev-db/postgresql-7.2 )

	nas? ( media-libs/nas )
	esd? ( media-sound/esound )

	X? ( virtual/x11 >=x11-libs/openmotif-2.1.30 )
	xface? ( media-libs/compface )
	tiff? ( media-libs/tiff )
	png? ( =media-libs/libpng-1.2* )
	jpeg? ( media-libs/jpeg )"

DEPEND="${RDEPEND}
	>=sys-libs/ncurses-5.2"

PROVIDE="virtual/xemacs virtual/editor"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "


src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	epatch ${FILESDIR}/emodules.info-21.4.8-gentoo.patch || die

	if [ ${ARCH} = "ppc" ] ; then
		epatch ${FILESDIR}/${P}-ppc.diff || die

		# xemacs broke with glibc-2.3.x. this code checks that condition
		# and patches xemacs appropriately.
		# http://sources.redhat.com/ml/bug-glibc/2002-11/msg00066.html
		glibc_version=`/sbin/ldconfig -V | head -n1 | sed -e "s/[^0-9]*[0-9]\.//" | sed -e "s/\.//"`
		if (( $glibc_version >= "31" ))
		then
			einfo "PPC runtime fix for glibc >= 2.3.1 (Gentoo bug #14458)"
			epatch ${FILESDIR}/${P}-ppc-glibc-2.3.x.diff
		fi
	fi

}

src_compile() {
	local myconf=""

	if use X;
	then
		myconf="${myconf}
			--with-x
			--with-xpm
			--with-dragndrop
			--with-gif=no"

		use tiff && myconf="${myconf} --with-tiff" ||
			myconf="${myconf} --without-tiff"
		use png && myconf="${myconf} --with-png" ||
			myconf="${myconf} --without-png"
		use jpeg && myconf="${myconf} --with-jpeg" ||
			myconf="${myconf} --without-jpeg"
		use xface && myconf="${myconf} --with-xface" ||
			myconf="${myconf} --without-xface"

		myconf="${myconf} --with-dialogs=lucid"
		myconf="${myconf} --with-widgets=lucid"
		myconf="${myconf} --with-scrollbars=lucid"
		myconf="${myconf} --with-menubars=lucid"
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

