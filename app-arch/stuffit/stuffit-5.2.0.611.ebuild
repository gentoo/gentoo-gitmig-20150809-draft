# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/stuffit/stuffit-5.2.0.611.ebuild,v 1.7 2003/06/16 14:02:08 phosphan Exp $

MY_P="stuffit520.611linux-i386"
DESCRIPTION="Aladdin Software's StuffIt and StuffIt Expander"
HOMEPAGE="http://www.stuffit.com/"
SRC_URI="http://www.aladdinsys.com/downloads/files/${MY_P}.tar.gz"
LICENSE="Stuffit"
SLOT="0"
KEYWORDS="x86 -ppc -sparc  -alpha"

IUSE=""
DEPEND=""
RDEPEND=""

S=${WORKDIR}
INSTALLDIR="/opt/stuffit"
RESTRICT="fetch nostrip"

pkg_nofetch() {
	einfo "Please download stuffit from"
	einfo "${SRC_URI}"
	einfo "and put the file in ${DISTDIR}"
	einfo
	einfo "Note that StuffIt requires registration within 15 days,"
	einfo "but StuffIt Expander is freeware."
	einfo
}

src_install() {

	# First do the binaries
	exeinto ${INSTALLDIR}/bin
	doexe ${S}/bin/stuff
	doexe ${S}/bin/unstuff

	# Now the registration binary
	exeinto ${INSTALLDIR}/extra
	doexe ${S}/bin/register

	# Now the documentation
	docinto stuff
	dodoc ${S}/doc/stuff/LICENSE
	dodoc ${S}/doc/stuff/README
	dodoc ${S}/doc/stuff/INSTALL
	dohtml ${S}/doc/stuff/stuff.html
	docinto unstuff
	dodoc ${S}/doc/unstuff/LICENSE
	dodoc ${S}/doc/unstuff/README
	dodoc ${S}/doc/unstuff/INSTALL
	dohtml ${S}/doc/unstuff/unstuff.html

	# And now the man pages
	doman ${S}/man/man1/*

	# Also add the executables to the path
	dodir etc/env.d
	echo -e "PATH=${INSTALLDIR}/bin\nROOTPATH=${INSTALLDIR}/bin" > \
		${D}/etc/env.d/10stuffit

}

pkg_postinst() {
	env-update
	einfo
	einfo "Reminder: StuffIt requires registration within 15 days."
	einfo "The registration program is located in ${INSTALLDIR}/extra"
	einfo
	einfo "The binaries are named 'stuff' and 'unstuff'"
	einfo
}

pkg_postrm() {
	# Get rid of those extraneous PATH entries.
	env-update
}
