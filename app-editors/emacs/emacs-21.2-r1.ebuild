# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs/emacs-21.2-r1.ebuild,v 1.1 2002/07/30 03:45:08 mkennedy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An incredibly powerful, extensible text editor"
SRC_URI="ftp://ftp.codefactory.se/pub/gnu/${PN}/${P}.tar.gz"
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
RDEPEND=""

PROVIDE="virtual/emacs"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

src_compile() {
	local myconf

	use nls	\
		|| myconf="${myconf} --disable-nls"

	use X	\
		&& myconf="${myconf} \
			--with-x \
			--with-xpm \
			--with-jpeg \
			--with-tiff \
			--with-gif \
			--with-png"	\
		|| myconf="${myconf} --without-x"

	use motif	\
		&& myconf="${myconf} --with-x-toolkit=motif"

	./configure		\
		--host=${CHOST} \
		--prefix=/usr \
		--libexecdir=/usr/lib \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		${myconf} || die

	emake || die
}

src_install () {
	make 	\
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

	einfo "Fixing permissions"
	find ${D} -perm 666 |xargs chmod 644
	find ${D} -perm 777 |xargs chmod 755

	dodoc BUGS ChangeLog README

	# Gives a warning if it doesn't exist
	dodir /usr/share/emacs/21.2/leim
	touch ${D}/usr/share/emacs/21.2/leim/.keep
}
