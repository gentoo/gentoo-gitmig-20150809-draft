# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/dosfstools/dosfstools-2.7.ebuild,v 1.1 2001/08/02 02:56:32 lamer Exp $
A=dosfstools-2.7.src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="dos filesystem tools"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/filesystems/dosfs/${A}"
HOMEPAGE="ftp.uni-erlangen.de /pub/Linux/LOCAL/dosfstools"
DEPEND=""

#RDEPEND=""
src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:PREFIX\ \=:PREFIX\ \=\ \/usr:" \
	-e "s:\/usr\/man:\/share\/man:" \
	Makefile | cat > Makefile
}
src_compile() {
	
	try make
	#try make
}

src_install () {
	
    try make PREFIX=${D}/usr install
	 dodoc CHANGES TODO
	 newdoc dosfsck/README README.dosfsck
	 newdoc dosfsck/CHANGES CHANGES.dosfsck
	 newdoc dosfsck/COPYING COPYING.dosfsck
	 newdoc mkdosfs/README README.mkdosfs
	 newdoc mkdosfs/ChangeLog ChangeLog.mkdosfs
}

