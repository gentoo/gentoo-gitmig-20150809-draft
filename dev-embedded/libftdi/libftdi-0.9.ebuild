# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/libftdi/libftdi-0.9.ebuild,v 1.5 2008/04/11 15:41:28 vapier Exp $

DESCRIPTION="Userspace access to FTDI USB interface chips"
HOMEPAGE="http://www.intra2net.com/opensource/ftdi/"
SRC_URI="http://www.intra2net.com/opensource/ftdi/TGZ/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=">=dev-libs/libusb-0.1.7
	app-doc/doxygen"

src_unpack() {
	unpack ${A}
	sed -i -e "s/^SUBDIRS = src examples doc/SUBDIRS = src doc/" "${S}"/Makefile.in
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc ChangeLog README
	for MANPAGE in doc/man/man3/* ; do doman ${MANPAGE} ; done
	insinto /usr/share/doc/${PF}
	doins -r doc/html
}

pkg_postinst() {
	elog "If you want to compile the examples, you need to :"
	elog "    tar xvfz ${PORTAGE_ACTUAL_DISTDIR}/${A}"
	elog "    cd ${PF}"
	elog "    ./configure"
	elog "    cd examples"
	elog "    sed -i -e 's/\$(top_builddir)\/src\/libftdi.la/\/usr\/lib\/libftdi.la/' Makefile*"
	elog "    make"
}
