# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-news/slrn/slrn-0.9.7.2.ebuild,v 1.1 2001/08/29 04:30:29 lamer Exp $
A="${P}.tar.gz ${P}-readactive.diff ${P}-forceauth.diff"
S=${WORKDIR}/${P}
DESCRIPTION="s-lang read news"
PATCH_URI="http://slrn.sourceforge.net/patches"
SRC_URI="ftp://slrn.sourceforge.net/pub/slrn/${P}.tar.gz
${PATCH_URI}/${P}-readactive.diff ${PATCH_URI}/${P}-forceauth.diff"
HOMEPAGE="http://slrn.sourceforge.net/"
DEPEND="virtual/glibc
		  virtual/mta
		>=sys-apps/sharutils-4.2.1
		 >=sys-libs/slang-1.4.4"

#RDEPEND=""

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	for i in slrn-0.9.7.2-{readactive,forceauth}.diff ; do
		patch -p1 < ${DISTDIR}/${i}
	done
}

src_compile() {

	try ./configure --infodir=/usr/share/info \
		--mandir=/usr/share/man --prefix=/usr \
		--with-slrnpull --host=${CHOST}
	
	emake || die
	#make || die
}

src_install () {
	
	# try make prefix=${D}/usr install

    try make DESTDIR=${D} DOCDIR=/usr/share/doc/${P} install
	  
}

