# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/bnr2/bnr2-0.7.3.ebuild,v 1.4 2003/09/11 01:27:15 msterret Exp $

IUSE=""

S=${WORKDIR}
DESCRIPTION="A great newsreader for alt.binaries.*"

SRC_URI="http://www.bnr2.org/BNR2.gz
	 http://www.bnr2.org/B2DBFix.gz
	 http://www.bnr2.org/libqtintf.so.gz
	 http://www.bnr2.org/libqt.so.2.gz"

HOMEPAGE="http://www.bnr2.org"
DEPEND="virtual/glibc"
RDEPEND="virtual/x11"
SLOT="0"
KEYWORDS="~x86"
LICENSE="freedist"

src_unpack() {
	cd ${WORKDIR}
	for f in ${A}; do
		cp ${DISTDIR}/$f .
		gunzip $f
	done
}

src_compile() {
	( echo '#!/bin/sh'
	  echo 'export LD_LIBRARY_PATH=/opt/bnr2/lib:$LD_LIBRARY_PATH'
	  echo '/opt/bnr2/bin/BNR2'
	) >bnr2
	( echo '#!/bin/sh'
	  echo 'export LD_LIBRARY_PATH=/opt/bnr2/lib:$LD_LIBRARY_PATH'
	  echo '/opt/bnr2/bin/B2DBFix'
	) >bnr2-dbfix
	chmod 755 BNR2 B2DBFix bnr2 bnr2-dbfix
}

src_install () {
	into /opt/bnr2
	dobin BNR2 B2DBFix
	dolib.so libqtintf.so libqt.so.2
	into /usr
	dobin bnr2 bnr2-dbfix
}
