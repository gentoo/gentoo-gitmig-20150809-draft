# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.6 2002/05/07 03:58:19 drobbins Exp

KEYWORDS="x86"

A="kinput2-v3.1-beta4.tar.gz"

S="${WORKDIR}/kinput2-v3.1-beta4"

DESCRIPTION="A Japanese input server which supports the XIM protocol"

SRC_URI="ftp://ftp.sra.co.jp/pub/x11/kinput2/${A}"

HOMEPAGE="http://www.nec.co.jp/canna/"

LICENSE="as-is"

DEPEND="virtual/glibc
	canna? >=app-i18n/canna-3.5_beta2-r1
	freewnn? >=app-i18n/freewnn-1.1.1_alpha19"

# Hack to default to canna if the user doesn't chose either canna or freewnn
if [ -z "`use freewnn`" ]
then
	DEPEND="${DEPEND}
		>=app-i18n/canna-3.5_beta2-r1"
fi

RDEPEND=${DEPEND}

SLOT=0

src_unpack() {

	# unpack the archive
	unpack ${A}

	# patch Kinput2.conf to ensure that files are installed into image dir
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}/gentoo.diff || die
	
	# hack to set define UseCanna, define UseWnn or both
	cp Kinput2.conf Kinput2.tmp
	use canna && sed -e "s:\/\* \#define UseCanna \*\/:\#define UseCanna:" Kinput2.tmp > Kinput2.conf
	cp Kinput2.conf Kinput2.tmp
 	use freewnn && sed -e "s:\/\* \#define UseWnn \*\/:\#define UseWnn:" Kinput2.tmp > Kinput2.conf  
	# default to UseCanna if we don't have freewnn in useflags
	cp Kinput2.conf Kinput2.tmp
	use freewnn || sed -e "s:\/\* \#define UseCanna \*\/:\#define UseCanna:" Kinput2.tmp > Kinput2.conf || die
          	
}

src_compile() {

	# create a Makefile from Kinput2.conf
	xmkmf          || die "xmkmf failed"
	make Makefiles || die "Makefile creation failed"

	# build Kinput2
	make depend ; make
}

src_install () {

	# install libs, executables, dictionaries
	make DESTDIR=${D} install     || die "installation failed"

	# install docs
	dodoc README NEWS
}
