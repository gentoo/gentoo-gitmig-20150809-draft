# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pilrc/pilrc-2.9_p10.ebuild,v 1.5 2004/07/15 00:00:19 agriffis Exp $

inherit eutils

# workout
PREV_PATCH_LEVEL=$((${PV#*p}-1))
MAJOR_PV=${PV%_p*}
PREV_PV=${MAJOR_PV}p${PREV_PATCH_LEVEL}
MY_PV=${PV/_/}

DESCRIPTION="Pilot Resource Compiler"
HOMEPAGE="http://www.ardiri.com/index.php?redir=palm&cat=pilrc"
SRC_URI="http://www.ardiri.com/download/files/palm/${PN}-${PREV_PV}.tgz
	http://www.ardiri.com/download/files/palm/${PN}-${MY_PV}.diff"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
IUSE="gtk"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )"

MAKEOPTS="${MAKEOPTS} -j1"
S=${WORKDIR}/${PN}-${PREV_PV}

src_unpack() {
	unpack ${A}

	# convert to unix text file and patch with the latest patch level
	chmod +x ${S}/src2unix.sh
	cd ${S}; ./src2unix.sh
	cp ${DISTDIR}/${PN}-${MY_PV}.diff ${WORKDIR}/${P}.diff
	edos2unix ${WORKDIR}/${P}.diff
	epatch ${WORKDIR}/${P}.diff
	# patch typo in Makefile.am
	cd ${S}; patch Makefile.am < ${FILESDIR}/${P}-Makefile.patch

	# seems to be missing depcomp
	cd ${S}; aclocal; autoconf
	cd ${S}; WANT_AUTOMAKE="1.6" automake --add-missing
}

src_compile() {
	econf `use_enable gtk pilrcui` || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc LICENSE.txt README.txt
	dohtml doc/*.html -r doc/images
}
