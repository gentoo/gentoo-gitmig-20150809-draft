# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/acroread-asianfonts/acroread-asianfonts-20020815.ebuild,v 1.3 2003/08/13 08:06:00 usata Exp $

DESCRIPTION="Asian Font Packs for Acrobat Reader 5.0"
HOMEPAGE="http://www.adobe.com/prodindex/acrobat/readstep.html"
BASE_URI="ftp://ftp.adobe.com/pub/adobe/acrobatreader/unix/5.x/"

SRC_URI="${BASE_URI}/chsfont.tar.gz
	${BASE_URI}/chtfont.tar.gz
	${BASE_URI}/jpnfont.tar.gz
	${BASE_URI}/korfont.tar.gz"

SLOT="0"
LICENSE="Adobe"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc
	app-text/acroread"
S="${WORKDIR}"

INSTALLDIR="/opt/Acrobat5/Resource/Font"

src_install() {
	dodir ${INSTALLDIR}
	for tarfile in `ls *KIT/*.TAR` ; do
		tar -xvf ${tarfile} --no-same-owner -C ${D}/${INSTALLDIR} || die
	done
	chown -R --dereference root:root ${D}/${INSTALLDIR}
}
