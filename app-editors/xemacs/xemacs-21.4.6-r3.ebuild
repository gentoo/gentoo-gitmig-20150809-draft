# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/xemacs/xemacs-21.4.6-r3.ebuild,v 1.3 2002/07/25 20:43:10 kabau Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="The ultimate emacs, IMO.  This is a non-FSF but still free for use version of the biggest text editor ever created."
EFS=1.27
BASE=1.58
SRC_URI="http://ftp.us.xemacs.org/ftp/pub/xemacs/xemacs-21.4/${P}.tar.gz
         http://ftp.us.xemacs.org/ftp/pub/xemacs/packages/efs-${EFS}-pkg.tar.gz
         http://ftp.us.xemacs.org/ftp/pub/xemacs/packages/xemacs-base-${BASE}-pkg.tar.gz"
HOMEPAGE="http://www.xemacs.org"

DEPEND="sys-libs/ncurses
	>=sys-libs/db-3
	nas? ( media-libs/nas )
	esd? ( media-sound/esound )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	X? ( virtual/x11
		media-libs/libpng
		media-libs/tiff
		media-libs/jpeg
		media-libs/compface )"
RDEPEND=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

PROVIDE="virtual/emacs"


src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz
	patch -p0 <${FILESDIR}/emodules.info-gentoo.patch
}

src_compile() {                           
local myopts
local soundopts
        
	if [ "`use X`" ]
	then
		myopts="--with-x	\
			--with-jpeg	\
			--with-png	\
			--with-tiff	\
			--with-xface	\
			--with-menubars=lucid	\
			--with-scrollbars=lucid"

		use motif	\
			&& myopts="${myopts} --with-dialogs=motif --with-widgets=motif"	\
			|| myopts="${myopts} --with-dialogs=lucid --with-widgets=lucid"
	else
		myopts="--without-x"
	fi
        
	use gpm	\
		&& myopts="${myopts} --with-gpm"	\
		|| myopts="${myopts} --without-gpm"
        
	soundopts="native"
	use nas	\
		&& soundopts="$soundopts,nas"
	
	use esd	\
		&& soundopts="$soundopts,esd"
	
	myopts="${myopts} --with-sound=$soundopts"

	./configure ${myopts} \
		--with-database=gnudbm \
		--prefix=/usr \
		--with-ncurses \
		--with-pop \
		--without-dragndrop \
		--with-xpm \
		--with-gif=no \
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
		install || die
        
	# Install the two packages
	dodir /usr/lib/xemacs/xemacs-packages/
	cd "${D}/usr/lib/xemacs/xemacs-packages/"
	unpack "efs-${EFS}-pkg.tar.gz"
	unpack "xemacs-base-${BASE}-pkg.tar.gz"
        
	#remove extraneous files
	cd "${D}/usr/share/info"
	rm -f dir info.info texinfo* termcap*
	cd "${S}"
	dodoc BUGS CHANGES-release COPYING GETTING* INSTALL ISSUES PROBLEMS README*
}
