# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/stuffit/stuffit-5.2.0.611.ebuild,v 1.18 2007/07/02 13:39:12 peper Exp $

MY_P="stuffit520.611linux-i386"
DESCRIPTION="Aladdin Software's StuffIt and StuffIt Expander"
HOMEPAGE="http://www.stuffit.com/"
SRC_URI="http://www.allume.com/downloads/files/${MY_P}.tar.gz"
LICENSE="Stuffit"
SLOT="0"
KEYWORDS="-* x86 amd64"

IUSE=""
DEPEND=""
RDEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs )"

S=${WORKDIR}
INSTALLDIR="/opt/stuffit"
RESTRICT="fetch strip"

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
	elog
	elog "Reminder: StuffIt requires registration within 15 days."
	elog "The registration program is located in ${INSTALLDIR}/extra"
	elog
	elog "The binaries are named 'stuff' and 'unstuff'"
	elog
}

pkg_postrm() {
	# Get rid of those extraneous PATH entries.
	env-update
}
