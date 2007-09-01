# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powersoftplus/powersoftplus-0.1.8.ebuild,v 1.1 2007/09/01 23:49:23 jurek Exp $

inherit autotools

DESCRIPTION="Ever UPS daemon"
HOMEPAGE="http://www.ever.com.pl"
SRC_URI="http://www.ever.com.pl/pl/pliki/${P}-x86.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=dev-embedded/powersoftplus-libftdi-${PV}*"
RDEPEND="${DEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Remove libftdi because we build this in powersoftplus-libftdi
	# Remove scripts because we provide our own startup scripts
	sed -i -e 's#^SUBDIRS = libftdi \(.*\) scripts#SUBDIRS = \1#' \
		   Makefile.am \
	|| die "sed failed"

	# Fix access violations
	sed -i -e \
		's#^CONFPATH = @CONFIG_PATH@$#CONFPATH = ${DESTDIR}/@CONFIG_PATH@#' \
		conf/Makefile.in \
	|| die "sed failed"

	# Fix access violations
	sed -i -e \
		's#^PIXPATH = @PIX_PATH@$#PIXPATH = ${DESTDIR}/@PIX_PATH@#' \
		pix/Makefile.in \
	|| die "sed failed"

	eautoreconf

	epatch ${FILESDIR}/${P}-reduceverbosity.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	doinitd ${FILESDIR}/powersoftplus
	dodoc AUTHORS COPYING INSTALL README TODO Pomoc.pdf
}
