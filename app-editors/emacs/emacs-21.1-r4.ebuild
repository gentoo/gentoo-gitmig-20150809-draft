# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs/emacs-21.1-r4.ebuild,v 1.19 2004/02/18 13:46:03 agriffis Exp $

IUSE="X nls motif"

S=${WORKDIR}/${P}
DESCRIPTION="An incredibly powerful, extensible text editor"
SRC_URI="mirror://gnu/emacs/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/emacs"

# Never use the sandbox, it causes Emacs to segfault on startup
SANDBOX_DISABLED="1"

DEPEND=">=sys-libs/ncurses-5.2
	sys-libs/gdbm
	X? ( 	virtual/x11
		>=media-libs/libungif-4.1.0
		>=media-libs/jpeg-6b-r2
		>=media-libs/tiff-3.5.5-r3
		>=media-libs/libpng-1.2.1 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	nls? ( >=sys-devel/gettext-0.10.35 )"

PROVIDE="virtual/emacs virtual/editor"

SLOT="0"
KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2"

src_unpack() {

	# Resolves bug 2104 # ppc fix

	SYSTEM_ARCH=`echo $ARCH |\
	sed -e s/[i]*.86/i386/ -e s/sun4u/sparc/ -e s/arm.*/arm/ -e s/sa110/arm/`
	if [ -z "$SYSTEM_ARCH" ]
	then
	 SYSTEM_ARCH=`uname -m |\
	 sed -e s/[i]*.86/i386/ -e s/sun4u/sparc/ -e s/arm.*/arm/ -e s/sa110/arm/`
	fi

	cd ${WORKDIR}
	unpack ${P}.tar.gz
	cd ${S}

	case $SYSTEM_ARCH in
	 ppc)
	  cat ${FILESDIR}/emacs-21.1-gentoo.diff | patch -p1 || die
	  ;;
	 i386)
	  ;;
	sparc)
	  ;;
	 arm)
	  ;;
	esac
}


src_compile() {
	local myconf


	use nls \
		|| myconf="${myconf} --disable-nls"

	use X \
		&& myconf="${myconf} \
			--with-x \
			--with-xpm \
			--with-jpeg \
			--with-tiff \
			--with-gif \
			--with-png" \
		|| myconf="${myconf} --without-x"

	use motif \
		&& myconf="${myconf} --with-x-toolkit=motif"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--libexecdir=/usr/lib \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		${myconf} || die

	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		libexecdir=${D}/usr/lib \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	cd ${D}/usr/share/info
	rm dir

	for i in *
	do
		mv ${i%.info} $i.info
	done

	dodoc BUGS ChangeLog README

	# Gives a warning if it doesn't exist
	keepdir /usr/share/emacs/21.1/leim
}
