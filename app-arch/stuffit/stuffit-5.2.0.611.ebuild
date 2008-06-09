# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/stuffit/stuffit-5.2.0.611.ebuild,v 1.19 2008/06/09 02:43:07 darkside Exp $

MY_P="stuffit520.611linux-i386"
DESCRIPTION="Aladdin Software's StuffIt and StuffIt Expander"
HOMEPAGE="http://www.stuffit.com/"
SRC_URI="http://my.smithmicro.com/downloads/files/stuffit520.611linux-i386.tar.gz"
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
	einfo "Note that StuffIt requires registration within 30 days,"
	einfo "but StuffIt Expander is freeware."
	einfo
}

src_install() {

	# First do the binaries
	exeinto ${INSTALLDIR}/bin
	doexe bin/stuff
	doexe bin/unstuff

	# Now the registration binary
	exeinto ${INSTALLDIR}/extra
	doexe bin/register

	# Now the documentation
	docinto stuff
	dodoc doc/stuff/README
	dohtml doc/stuff/stuff.html
	docinto unstuff
	dodoc doc/unstuff/README
	dohtml doc/unstuff/unstuff.html

	# And now the man pages
	doman man/man1/*

	# Also add the executables to the path
	dodir /etc/env.d
	echo -e "PATH=${INSTALLDIR}/bin\nROOTPATH=${INSTALLDIR}/bin" > \
		${D}/etc/env.d/10stuffit

}

pkg_postinst() {
	env-update
	elog
	elog "Reminder: StuffIt requires registration within 30 days."
	elog "The registration program is located in ${INSTALLDIR}/extra"
	elog
	elog "The binaries are named 'stuff' and 'unstuff'"
	elog
}

pkg_postrm() {
	# Get rid of those extraneous PATH entries.
	env-update
}
